# frozen_string_literal: true

module ElementComponent
  class Element
    attr_reader :element, :attributes, :contents, :html

    def initialize(element, closing_tag: true, **attribute, &block)
      @element = element
      @closing_tag = closing_tag
      @html = String.new

      add_attribute!(attribute)
      reset_contents!
      instance_eval(&block) if block
    end

    def add_content!(content)
      reset_contents!

      add_content(content)
    end

    def add_content(content = nil, &block)
      if block_given?
        @contents.push(block)
      else
        @contents.push(content)
      end

      self
    end

    def add_attribute!(hash_attr)
      reset_attributes!

      add_attribute(hash_attr)
    end

    def add_attribute(hash_attr)
      hash_attr.each_key do |attr|
        @attributes[attr] = [] unless @attributes.key?(attr)

        hash_attr[attr]
          .to_s
          .split
          .each do |value|
            @attributes[attr].push(value)
          end
      end

      self
    end

    def remove_attribute(attribute)
      @attributes = @attributes.except(attribute)
    end

    def remove_attribute_value(attribute, value)
      attributes[attribute].delete(value)
    end

    def reset_contents!
      @contents = []
    end

    def reset_attributes!
      @attributes = {}
    end

    def new_element(*args, **kargs) = Element.new(*args, **kargs)

    def render
      @html = String.new

      before_render if respond_to? "before_render"

      if respond_to? "around_render"
        around_render { build }
      else
        build
      end

      after_render(@html) if respond_to? "after_render"

      @html
    end

    private

    def build
      @html << "<#{@element}"
      @html << (mount_attributes.empty? ? ">" : " #{mount_attributes}>")
      @html << mount_content
      @html << "</#{@element}>" if @closing_tag
      @html
    end

    def mount_attributes
      @attributes.map { |attr| "#{attr[0].to_sym}=\"#{attr[1].join(" ")}\"" }.join(" ")
    end

    def mount_content
      @contents.map do |content|
        case content
        in Element
          content.render
        else
          content.to_s
        end
      end.join
    end
  end
end
