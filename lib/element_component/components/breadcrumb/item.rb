# frozen_string_literal: true

module ElementComponent
  module Components
    class BreadcrumbItem < Element
      def initialize(content = nil, href: nil, active: false, **attributes, &block)
        super("li", &block)

        add_attribute(class: "breadcrumb-item")
        add_attribute(class: "active") if active
        add_attribute("aria-current": "page") if active
        add_attribute(attributes) unless attributes.empty?

        @href = href
        add_content(content) if content
      end

      private

      def mount_content
        inner = super
        if @href && @contents.none?(Element)
          "<a href=\"#{@href}\">#{inner}</a>"
        else
          inner
        end
      end
    end
  end
end
