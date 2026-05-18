# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarBrand < Element
      def initialize(content = nil, **attributes, &)
        super("a", content, **attributes, &)

        add_attribute(class: "navbar-brand")
      end
    end
  end
end
