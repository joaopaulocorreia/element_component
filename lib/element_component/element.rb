# frozen_string_literal: true

require "cgi"

module ElementComponent
  class Element
    attr_reader :element, :attributes, :contents

    def initialize(element, content = nil, closing_tag: true, **attribute, &block)
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
      @contents.push(block) if block_given?

      self
    end

    def add_attribute!(hash_attr)
      reset_attributes!
      add_attribute(hash_attr)
    end

    def add_attribute(hash_attr)
      hash_attr.each do |attr, value|
        @attributes[attr] = [] unless @attributes.key?(attr)
        resolve_attribute_values(value, attr).each { |v| @attributes[attr].push(v) }
      end

      self
    end

    def remove_attribute(attribute)
      @attributes = @attributes.except(attribute)
    end

    def remove_attribute_value(attribute, value)
      return unless @attributes[attribute]

      @attributes[attribute].delete(value)
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
      return @cached_html if @cache_enabled && @cached_html

      @html = String.new

      before_render if respond_to? "before_render"

      if respond_to? "around_render"
        around_render { build }
      else
        build
      end

      after_render(@html) if respond_to? "after_render"

      cache_store!

      defined?(ActiveSupport::SafeBuffer) ? @html.html_safe : SafeString.new(@html)
    end

    def render_in(*) = render

    def format_html(indent: 2)
      ElementComponent.format_html(render, indent: indent)
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

    def build
      @html << opening_tag
      @html << mount_content(contents)
      @html << closing_tag
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
          c.render
        when Proc
          buffer = []
          c.call(buffer)
          render_content(buffer)
        when SafeString
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

    def cache_store!
      return unless @cache_enabled

      key = @cache_key || hash
      if defined?(Rails.cache)
        Rails.cache.fetch(key, expires_in: @cache_expires_in) { @html }
      else
        @cached_html = @html
      end
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
