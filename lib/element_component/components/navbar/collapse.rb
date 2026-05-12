# frozen_string_literal: true

module ElementComponent
  module Components
    class NavbarCollapse < Element
      def initialize(content = nil, id: nil, **attributes, &block)
        super("div", &block)

        add_attribute(class: "collapse")
        add_attribute(class: "navbar-collapse")
        add_attribute(id: id) if id
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
