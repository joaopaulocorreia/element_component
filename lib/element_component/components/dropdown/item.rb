# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownItem < Element
      VALID_TYPES = %i[button link].freeze

      def initialize(type: :link, href: "#", active: false, disabled: false, **attributes, &block)
        tag = type == :button ? "button" : "a"
        super("li", &block)

        inner = Element.new(tag, class: "dropdown-item", href: (tag == "a" ? href : nil),
                                 type: (tag == "button" ? "button" : nil), **attributes)
        inner.add_attribute(class: "active") if active
        inner.add_attribute(class: "disabled") if disabled
        inner.add_attribute(tabindex: "-1") if disabled
        inner.add_attribute("aria-disabled": "true") if disabled

        inner.add_content(&block) if block

        @inner_item = inner
      end

      private

      def mount_content
        inner = super
        @inner_item&.add_content(inner)
        "<li>#{@inner_item&.render || inner}</li>"
      end
    end
  end
end
