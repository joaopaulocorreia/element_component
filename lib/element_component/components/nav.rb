# frozen_string_literal: true

require_relative "nav/item"
require_relative "nav/link"

module ElementComponent
  module Components
    class Nav < Element
      VALID_TYPES = %i[tabs pills underline].freeze

      def initialize(type: nil, fill: false, justified: false, vertical: false, **attributes, &block)
        super("ul", &block)

        add_attribute(class: "nav")
        add_attribute(class: "nav-#{type}") if type
        add_attribute(class: "nav-fill") if fill
        add_attribute(class: "nav-justified") if justified
        add_attribute(class: "flex-column") if vertical
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
