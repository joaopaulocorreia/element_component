# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarNav < Element
      def initialize(content = nil, **attributes, &)
        super("ul", &)

        add_attribute(class: "navbar-nav")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
