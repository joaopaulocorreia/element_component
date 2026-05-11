# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertHeading < Element
      def initialize(**attributes)
        super("h4")

        add_attribute(class: "alert-heading")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
