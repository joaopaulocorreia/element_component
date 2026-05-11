# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarNav < Element
      def initialize(**attributes, &)
        super("ul", &)

        add_attribute(class: "navbar-nav")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
