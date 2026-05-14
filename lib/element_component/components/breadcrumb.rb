# frozen_string_literal: true

require_relative "breadcrumb/item"

module ElementComponent
  module Components
    class Breadcrumb < Element
      def initialize(content = nil, **attributes, &)
        super("nav", &)

        add_attribute("aria-label": "breadcrumb")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end

      def build
        @html << opening_tag
        @html << "<ol class=\"breadcrumb\">"
        @html << mount_content(contents)
        @html << "</ol>"
        @html << closing_tag
        @html
      end
    end
  end
end
