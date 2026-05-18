# frozen_string_literal: true

module ElementComponent
  module Components
    class PageItem < Element
      def initialize(content = nil, active: false, disabled: false, href: "#", **attributes, &)
        super("li", content, **attributes, &)

        add_attribute(class: "page-item")
        add_attribute(class: "active") if active
        add_attribute(class: "disabled") if disabled
        add_attribute("aria-current": "page") if active

        @page_href = href
        @page_disabled = disabled
      end

      private

      def wrap_content(inner, _contents)
        "<a class=\"page-link\" href=\"#{@page_href}\"#{' tabindex="-1"' if @page_disabled}>#{inner}</a>"
      end
    end
  end
end
