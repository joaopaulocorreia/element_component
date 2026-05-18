# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownItem < Element
      def initialize(content = nil, href: "#", active: false, disabled: false, **attributes)
        super("li", **attributes)

        button = ElementComponent::Button.new(content, href:)
        button.remove_attribute(:class)
        button.add_attribute(class: "dropdown-item")
        button.add_attribute(class: "active") if active
        button.add_attribute(class: "disabled") if disabled
        button.add_attribute(tabindex: "-1") if disabled
        button.add_attribute("aria-disabled": "true") if disabled

        add_content(button)
      end
    end
  end
end
