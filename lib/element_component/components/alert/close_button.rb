# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertCloseButton < Element
      def initialize(**attributes)
        super("button", closing_tag: false)

        add_attribute(class: "btn-close")
        add_attribute(type: "button")
        add_attribute("data-bs-dismiss": "alert")
        add_attribute("aria-label": "Close")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
