# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarBrand < Element
      def initialize(content = nil, href: "#", **attributes, &block)
        super("a", &block)

        add_attribute(class: "navbar-brand")
        add_attribute(href: href)
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
