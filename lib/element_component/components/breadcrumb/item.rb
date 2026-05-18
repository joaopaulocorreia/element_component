# frozen_string_literal: true

module ElementComponent
  module Components
    class BreadcrumbItem < Element
      def initialize(content = nil, active: false, **attributes, &)
        super("li", content, **attributes, &)

        add_attribute(class: "breadcrumb-item")
        add_attribute(class: "active") if active
        add_attribute("aria-current": "page") if active
      end
    end
  end
end
