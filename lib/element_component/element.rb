# frozen_string_literal: true

require "cgi"

module ElementComponent
  class Element
    attr_reader :element, :attributes, :contents

    def initialize(element = nil, content = nil, closing_tag: true, **attribute, &block)
      @element = element
      @closing_tag = closing_tag
      @html = String.new

      add_attribute!(attribute)
      reset_contents!

      add_content(content, &block)
    end

    def add_content!(content = nil, &)
      reset_contents!
      add_content(content, &)
    end

    def add_content(content = nil, &block)
      @contents.push(*Array(content)) if content
      block.call(self) if block_given?

      self
    end

    def add_attribute!(hash_attr)
      reset_attributes!
      add_attribute(hash_attr)
    end

    def <<(content)
      add_content(content)
      self
    end

    def add_attribute(hash_attr)
      return self unless hash_attr.is_a?(Hash) && hash_attr.any?

      hash_attr.each do |attr, value|
        @attributes[attr] = [] unless @attributes.key?(attr)
        resolve_attribute_values(value, attr).each { |v| @attributes[attr].push(v) }
      end

      self
    end

    def remove_attribute(attribute)
      @attributes = @attributes.except(attribute)
    end

    def remove_attribute_value(attribute, values)
      return unless @attributes[attribute]

      values = Array(values)
      values.each { |value| @attributes[attribute].delete(value) }

      @attributes.delete(attribute) if @attributes[attribute].empty?
    end

    def reset_contents!
      @contents = []
    end

    def reset_attributes!
      @attributes = {}
    end

    def new_element(...) = Element.new(...)

    def html_safe
      @__html_safe = true
      self
    end

    def html_safe?
      @__html_safe
    end

    def render
      if @cache_enabled
        cached = read_cache
        return finalize(cached) if cached
      end

      template if respond_to? "template"

      @html = String.new

      before_render if respond_to? "before_render"

      if respond_to? "around_render"
        around_render { build }
      else
        build
      end

      after_render(@html) if respond_to? "after_render"

      write_cache if @cache_enabled

      finalize(@html)
    end

    def render_in(view_context)
      @view_context = view_context

      render
    end

    def cache(key = nil, expires_in: nil)
      @cache_enabled = true
      @cache_key = key
      @cache_expires_in = expires_in
      self
    end

    def expire_cache!
      @cached_html = nil
      @cache_enabled = false
      self
    end

    def cached?
      @cache_enabled
    end

    private

    def validate_option!(value, allowed, name)
      return if value.nil? || allowed.include?(value)

      raise ArgumentError,
            "Invalid #{name}: #{value.inspect}. Valid options: #{allowed.map(&:inspect).join(", ")}"
    end

    def build
      @html << opening_tag if @element
      @html << mount_content(contents)
      @html << closing_tag if @element
      @html
    end

    def opening_tag
      attrs = mount_attributes
      attrs.empty? ? "<#{@element}>" : "<#{@element} #{attrs}>"
    end

    def closing_tag
      @closing_tag ? "</#{@element}>" : ""
    end

    def mount_attributes
      @attributes.map { |attr, values| "#{attr}=\"#{escape_html(values.join(" "))}\"" }.join(" ")
    end

    def mount_content(contents)
      inner = render_content(contents)
      wrap_content(inner, contents)
    end

    def render_content(contents)
      contents.map do |c|
        case c
        when Element
          c.render_in(@view_context)
        when ->(c) { c.respond_to?(:html_safe?) && c.html_safe? }
          c.to_s
        else
          escape_html(c.to_s)
        end
      end.join
    end

    def wrap_content(inner, _contents)
      inner
    end

    def escape_html(value)
      CGI.escapeHTML(value.to_s)
    end

    def finalize(html)
      defined?(ActiveSupport::SafeBuffer) ? html.html_safe : SafeString.new(html)
    end

    def read_cache
      return @cached_html if @cached_html
      return unless rails_cache?

      cached = Rails.cache.read(cache_key)
      @cached_html = cached if cached
      cached
    end

    def write_cache
      @cached_html = @html
      Rails.cache.write(cache_key, @html, expires_in: @cache_expires_in) if rails_cache?
    end

    def cache_key
      @cache_key || hash
    end

    def rails_cache?
      defined?(Rails) && Rails.respond_to?(:cache) && Rails.cache
    end

    def resolve_attribute_values(value, attr)
      case value
      when Array
        value.map(&:to_s)
      when nil
        []
      else
        v = value.to_s
        attr == :class ? v.split : [v]
      end
    end
  end
end
