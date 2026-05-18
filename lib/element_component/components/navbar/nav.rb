# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarNav < Element
      def initialize(content = nil, **attributes, &)
        super("ul", content, **attributes, &)

        add_attribute(class: "navbar-nav")
      end
    end
  end
end
