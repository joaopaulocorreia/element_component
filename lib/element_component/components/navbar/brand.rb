# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarBrand < Element
      def initialize(href: "#", **attributes, &block)
        super("a", &block)

        add_attribute(class: "navbar-brand")
        add_attribute(href: href)
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
