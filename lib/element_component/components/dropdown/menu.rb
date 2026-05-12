# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownMenu < Element
      def initialize(content = nil, align: nil, **attributes, &block)
        super("ul", &block)

        add_attribute(class: "dropdown-menu")
        add_attribute(class: "dropdown-menu-#{align}") if align
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
