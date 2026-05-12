# frozen_string_literal: true

module ElementComponent
  module Components
    class NavItem < Element
      def initialize(content = nil, **attributes, &)
        super("li", &)

        add_attribute(class: "nav-item")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
