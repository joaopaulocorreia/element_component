# frozen_string_literal: true

module ElementComponent
  module Core
    class Element
      attr_reader :element, :attributes, :contents

      def initialize(element, content: [], attribute: {}, closing_tag: true)
        @element = element
        @closing_tag = closing_tag
        @objects = []

        reset_attributes!
        reset_contents!

        if content.is_a? Array
          content.each { |item| add_content item }
        else
          add_content content
        end

        attribute.each_key { |key| add_attribute key, attribute[key] }
      end

      def add_content(content, reset: false)
        reset_contents! if reset
        @contents.push(content)

        content
      end

      def add_attribute(attribute, value, reset: false)
        attribute = attribute.to_sym

        @attributes.delete attribute if reset

        return @attributes[attribute].push(value) if @attributes.key?(attribute)

        @attributes[attribute] = [value]
      end

      def remove_attribute!(attribute)
        attribute = attribute.to_sym
        @attributes = @attributes.except(attribute)
      end

      def remove_attribute_value(attribute, value)
        attribute = attribute.to_sym
        attributes[attribute].delete(value)
      end

      def reset_contents!
        @contents = []
      end

      def reset_attributes!
        @attributes = {}
      end

      def build
        html = "<#{@element}"
        html << (mount_attributes.empty? ? ">" : " #{mount_attributes}>")

        html << mount_content

        html << "</#{@element}>" if @closing_tag
      end

      private

      def mount_attributes
        @attributes.map { |attr| "#{attr[0].to_sym}=\"#{attr[1].join(" ")}\"" }.join(" ")
      end

      def mount_content
        @contents.map { |content| content.is_a?(Element) ? content.build : content.to_s }.join
      end
    end
  end
end
