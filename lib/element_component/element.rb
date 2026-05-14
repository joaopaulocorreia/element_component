# frozen_string_literal: true

require "cgi"

module ElementComponent
  class Element
    attr_reader :element, :attributes, :contents

    def initialize(element, content = nil, closing_tag: true, **attribute, &block)
      @element = element
      @closing_tag = closing_tag
      @html = String.new

      debug_log(:init, "new <#{element}>", closing_tag: closing_tag)

      add_attribute!(attribute)
      reset_contents!

      add_content(content, &block)
    end

    def add_content!(content = nil, &)
      debug_log(:content, "add_content! — reset then add")
      reset_contents!
      add_content(content, &)
    end

    def add_content(content = nil, &block)
      added = []
      added.concat(Array(content)) if content
      added << "<block>" if block_given?

      @contents.push(*Array(content)) if content
      @contents.push(block) if block_given?

      debug_log(:content, "add_content #{added.inspect}", count: @contents.count)
      self
    end

    def add_attribute!(hash_attr)
      debug_log(:attribute, "add_attribute! — reset then add")
      reset_attributes!
      add_attribute(hash_attr)
    end

    def add_attribute(hash_attr)
      hash_attr.each do |attr, value|
        before = @attributes[attr]&.dup || []
        @attributes[attr] = [] unless @attributes.key?(attr)

        resolve_attribute_values(value, attr).each { |v| @attributes[attr].push(v) }

        debug_log(:attribute, "#{attr}=#{value.inspect}",
                  attr: attr,
                  before: before,
                  after: @attributes[attr].dup)
      end

      self
    end

    def remove_attribute(attribute)
      debug_log(:attribute, "remove #{attribute}")
      @attributes = @attributes.except(attribute)
    end

    def remove_attribute_value(attribute, value)
      return unless @attributes[attribute]

      @attributes[attribute].delete(value)
      debug_log(:attribute, "remove #{attribute}=#{value.inspect}",
                remaining: @attributes[attribute].dup)
      @attributes.delete(attribute) if @attributes[attribute].empty?
    end

    def reset_contents!
      debug_log(:content, "reset contents") unless @contents.nil? || @contents.empty?
      @contents = []
    end

    def reset_attributes!
      debug_log(:attribute, "reset attributes") unless @attributes.nil? || @attributes.empty?
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
      if @cache_enabled && @cached_html
        debug_log(:cache, "HIT — returning cached")
        return @cached_html
      end

      debug_log(:cache, "MISS — rendering fresh") if @cache_enabled

      @html = String.new
      t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      debug_log(:render, "render START")
      debug_log(:hook, "before_render") if respond_to?("before_render")
      before_render if respond_to? "before_render"

      if respond_to? "around_render"
        debug_log(:hook, "around_render wrapping build")
        around_render { build }
      else
        build
      end

      debug_log(:hook, "after_render") if respond_to?("after_render")
      after_render(@html) if respond_to? "after_render"

      cache_store!

      elapsed = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0) * 1000).round(3)
      debug_log(:render, "render END (#{elapsed}ms, #{@html.length} chars)", elapsed_ms: elapsed)

      defined?(ActiveSupport::SafeBuffer) ? @html.html_safe : SafeString.new(@html)
    end

    def render_in(*) = render

    def cache(key = nil, expires_in: nil)
      @cache_enabled = true
      @cache_key = key
      @cache_expires_in = expires_in
      debug_log(:cache, "cache enabled (key: #{key || "auto"}, expires_in: #{expires_in || "none"})")
      self
    end

    def expire_cache!
      @cached_html = nil
      @cache_enabled = false
      debug_log(:cache, "cache expired")
      self
    end

    def cached?
      @cache_enabled
    end

    def debug_mode!
      @_debug_enabled = true
      self
    end

    def debug_mode?
      @_debug_enabled
    end

    def debug_info
      {
        element: @element,
        closing_tag: @closing_tag,
        attributes: @attributes.transform_values(&:dup),
        contents: @contents.map { |c| describe_content(c) },
        cache_enabled: @cache_enabled,
        cached_html: @cached_html ? "(#{@cached_html.length} chars)" : nil,
        html_safe: @__html_safe,
        debug_enabled: debug_mode?,
        debug_events: (@_debug_events || []).map(&:dup)
      }
    end

    private

    def describe_content(item)
      case item
      when Element then "#<Element #{item.element}>"
      when Proc then "<Proc>"
      when SafeString then "SafeString(#{item.length} chars)"
      else item.class.name
      end
    end

    def debug_log(category, message, data = {})
      return unless debug_mode? || ElementComponent.debug_enabled?

      entry = {
        time: Process.clock_gettime(Process::CLOCK_MONOTONIC),
        category: category,
        element: @element,
        message: message
      }.merge(data)

      (@_debug_events ||= []) << entry

      ElementComponent.debug.log(category, "[#{@element}] #{message}", data)
    end

    def build
      debug_log(:build, "build <#{@element}>")
      @html << opening_tag
      @html << mount_content(contents)
      @html << closing_tag
      @html
    end

    def opening_tag
      attrs = mount_attributes
      tag = attrs.empty? ? "<#{@element}>" : "<#{@element} #{attrs}>"
      debug_log(:opening_tag, tag)
      tag
    end

    def closing_tag
      tag = @closing_tag ? "</#{@element}>" : ""
      debug_log(:closing_tag, tag.empty? ? "(self-closing)" : tag)
      tag
    end

    def mount_attributes
      result = @attributes.map { |attr, values| "#{attr}=\"#{escape_html(values.join(" "))}\"" }.join(" ")
      debug_log(:mount_attrs, result.empty? ? "(none)" : result)
      result
    end

    def mount_content(contents)
      inner = render_content(contents)
      result = wrap_content(inner, contents)
      debug_log(:mount_content, result.length.positive? ? "(#{result.length} chars)" : "(empty)")
      result
    end

    def render_content(contents)
      contents.map do |c|
        case c
        when Element
          debug_log(:content_type, "render #{c.class.name}", type: "Element", tag: c.element)
          c.render
        when Proc
          debug_log(:content_type, "render Proc", type: "Proc")
          buffer = []
          c.call(buffer)
          render_content(buffer)
        when SafeString
          debug_log(:content_type, "render SafeString", type: "SafeString")
          c.to_s
        else
          raw = c.to_s
          debug_log(:content_type, "render String", type: "String")
          debug_log(:escape, "escaping #{raw[0..50].inspect}", original: raw[0..50])
          escape_html(raw)
        end
      end.join
    end

    def wrap_content(inner, _contents)
      debug_log(:wrap_content, "(#{inner.length} chars)")
      inner
    end

    def escape_html(value)
      CGI.escapeHTML(value.to_s)
    end

    def cache_store!
      return unless @cache_enabled

      key = @cache_key || hash
      debug_log(:cache, "STORING (key: #{key})")
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
