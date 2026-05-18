# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarCollapse < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "collapse")
        add_attribute(class: "navbar-collapse")
      end
    end
  end
end
