# frozen_string_literal: true

module ElementComponent
  module Components
    class ListGroupItem < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(content = nil, variant: nil, active: false, disabled: false, href: nil, **attributes, &block)
        tag = href ? "a" : "li"
        super(tag, &block)

        add_attribute(class: "list-group-item")
        add_attribute(class: "list-group-item-action") if href || tag == "a"
        add_attribute(class: "list-group-item-#{variant}") if variant
        add_attribute(class: "active") if active
        add_attribute(class: "disabled") if disabled
        add_attribute(href: href) if href
        add_attribute("aria-current": "true") if active
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
