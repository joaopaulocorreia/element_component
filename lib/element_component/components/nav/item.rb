# frozen_string_literal: true

module ElementComponent
  module Components
    class NavItem < Element
      def initialize(content = nil, **attributes, &)
        super("li", content, **attributes, &)

        add_attribute(class: "nav-item")
      end
    end
  end
end
