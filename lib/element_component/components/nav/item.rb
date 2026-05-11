# frozen_string_literal: true

module ElementComponent
  module Components
    class NavItem < Element
      def initialize(**attributes, &)
        super("li", &)

        add_attribute(class: "nav-item")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
