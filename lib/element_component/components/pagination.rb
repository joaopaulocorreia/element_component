# frozen_string_literal: true

require_relative "pagination/item"

module ElementComponent
  module Components
    class Pagination < Element
      VALID_SIZES = %i[sm lg].freeze

      def initialize(content = nil, size: nil, **attributes, &block)
        @pagination_size = size
        super("nav", &block)

        add_attribute("aria-label": "Pagination")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end

      private

      def build
        @html << opening_tag
        @html << "<ul class=\"pagination"
        @html << " pagination-#{@pagination_size}" if @pagination_size
        @html << "\">"
        @html << mount_content(contents)
        @html << "</ul>"
        @html << closing_tag
        @html
      end
    end
  end
end
