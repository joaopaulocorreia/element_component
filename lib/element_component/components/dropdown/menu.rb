# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownMenu < Element
      def initialize(align: nil, **attributes, &block)
        super("ul", &block)

        add_attribute(class: "dropdown-menu")
        add_attribute(class: "dropdown-menu-#{align}") if align
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
