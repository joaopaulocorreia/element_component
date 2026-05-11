# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertLink < Element
      def initialize(href: "#", **attributes)
        super("a")

        add_attribute(class: "alert-link")
        add_attribute(href: href)
        attributes.each { |key, value| add_attribute(key => value) }
      end
    end
  end
end
