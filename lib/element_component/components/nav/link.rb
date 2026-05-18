# frozen_string_literal: true

module ElementComponent
  module Components
    class NavLink < Element
      def initialize(content = nil, active: false, disabled: false, **attributes, &)
        super("a", content, **attributes, &)

        add_attribute(class: "nav-link")
        add_attribute(class: "active") if active
        add_attribute(class: "disabled") if disabled
        add_attribute("aria-current": "page") if active
      end
    end
  end
end
