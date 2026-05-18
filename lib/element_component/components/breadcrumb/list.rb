# frozen_string_literal: true

module ElementComponent
  module Components
    class BreadcrumbList < Element
      def initialize(content = nil, **attributes, &)
        super("ol", content, **attributes, &)

        add_attribute(class: "breadcrumb")
      end
    end
  end
end
