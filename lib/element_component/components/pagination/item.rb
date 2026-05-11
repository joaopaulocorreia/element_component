# frozen_string_literal: true

module ElementComponent
  module Components
    class PageItem < Element
      def initialize(active: false, disabled: false, href: "#", **attributes, &block)
        super("li", &block)

        add_attribute(class: "page-item")
        add_attribute(class: "active") if active
        add_attribute(class: "disabled") if disabled
        add_attribute("aria-current": "page") if active
        add_attribute(attributes) unless attributes.empty?

        @page_href = href
        @page_disabled = disabled
      end

      private

      def mount_content
        inner = super
        "<a class=\"page-link\" href=\"#{@page_href}\"#{' tabindex="-1"' if @page_disabled}>#{inner}</a>"
      end
    end
  end
end
