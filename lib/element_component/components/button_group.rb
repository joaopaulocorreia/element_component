# frozen_string_literal: true

module ElementComponent
  module Components
    class ButtonGroup < Element
      VALID_SIZES = %i[sm lg].freeze

      def initialize(size: nil, vertical: false, **attributes, &block)
        super("div", &block)

        add_attribute(class: vertical ? "btn-group-vertical" : "btn-group")
        add_attribute(class: "btn-group-#{size}") if size
        add_attribute(role: "group")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
