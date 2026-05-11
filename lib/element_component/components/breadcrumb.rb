# frozen_string_literal: true

require_relative "breadcrumb/item"

module ElementComponent
  module Components
    class Breadcrumb < Element
      def initialize(**attributes, &)
        super("nav", &)

        add_attribute("aria-label": "breadcrumb")
        add_attribute(attributes) unless attributes.empty?
      end

      def build
        @html << "<#{@element}"
        @html << (mount_attributes.empty? ? ">" : " #{mount_attributes}>")
        @html << "<ol class=\"breadcrumb\">"
        @html << mount_content
        @html << "</ol>"
        @html << "</#{@element}>" if @closing_tag
        @html
      end
    end
  end
end
