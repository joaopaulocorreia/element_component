# frozen_string_literal: true

require_relative "nav/item"
require_relative "nav/link"

module ElementComponent
  module Components
    class Nav < Element
      VALID_VARIANTS = %i[tabs pills underline].freeze

      def initialize(content = nil, variant: nil, fill: false, justified: false, vertical: false, **attributes, &)
        super("ul", content, **attributes, &)

        add_attribute(class: "nav")
        add_attribute(class: "nav-#{variant}") if variant
        add_attribute(class: "nav-fill") if fill
        add_attribute(class: "nav-justified") if justified
        add_attribute(class: "flex-column") if vertical
      end
    end
  end
end
