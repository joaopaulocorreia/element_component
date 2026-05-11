# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertLink < Element
      def initialize(href: "#", **attributes)
        super("a")

        add_attribute(class: "alert-link")
        add_attribute(href: href)
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
