# frozen_string_literal: true

module ElementComponent
  module Components
    class NavLink < Element
      def initialize(content = nil, href: "#", active: false, disabled: false, **attributes, &block)
        super("a", &block)

        add_attribute(class: "nav-link")
        add_attribute(class: "active") if active
        add_attribute(class: "disabled") if disabled
        add_attribute(href: href)
        add_attribute("aria-current": "page") if active
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
