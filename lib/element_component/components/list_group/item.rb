# frozen_string_literal: true

module ElementComponent
  module Components
    class ListGroupItem < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(content = nil, variant: nil, active: false, disabled: false, href: nil, **attributes, &)
        tag = href ? "a" : "li"

        super(tag, content, **attributes, &)

        @variant = variant
        @active = active
        @disabled = disabled

        add_attribute(class: "list-group-item")
        add_attribute(class: "list-group-item-action") if href || tag == "a"
        add_attribute(class: "list-group-item-#{variant}") if variant
        add_attribute(class: "active", "aria-current": "true") if active
        add_attribute(class: "disabled") if disabled
        add_attribute(href: href) if href
      end
    end
  end
end
