# frozen_string_literal: true

require_relative "breadcrumb/item"
require_relative "breadcrumb/list"

module ElementComponent
  module Components
    class Breadcrumb < Element
      def initialize(content = nil, **attributes, &)
        super("nav", content, **attributes, &)

        add_attribute("aria-label": "breadcrumb")
      end
    end
  end
end
