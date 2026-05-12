# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertLink < Element
      def initialize(content = nil, href: "#", **attributes)
        super("a")

        add_attribute(class: "alert-link")
        add_attribute(href: href)
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
