# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertHeading < Element
      def initialize(content = nil, **attributes)
        super("h4")

        add_attribute(class: "alert-heading")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
