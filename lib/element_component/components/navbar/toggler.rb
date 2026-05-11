# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarToggler < Element
      def initialize(target: nil, **attributes)
        super("button", closing_tag: false)

        add_attribute(class: "navbar-toggler")
        add_attribute(type: "button")
        add_attribute("data-bs-toggle": "collapse")
        add_attribute("data-bs-target": "##{target}") if target
        add_attribute("aria-controls": target) if target
        add_attribute("aria-expanded": "false")
        add_attribute("aria-label": "Toggle navigation")
        add_attribute(attributes) unless attributes.empty?

        add_content(Element.new("span", class: "navbar-toggler-icon"))
      end
    end
  end
end
