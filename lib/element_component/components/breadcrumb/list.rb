# frozen_string_literal: true

module ElementComponent
  module Components
    class BreadcrumbList < Element
      def initialize(content = nil, **attributes, &)
        super("ol", &)
        add_attribute(class: "breadcrumb")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
