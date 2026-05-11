# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertHeading < Element
      def initialize(**attributes)
        super("h4")

        add_attribute(class: "alert-heading")
        attributes.each { |key, value| add_attribute(key => value) }
      end
    end
  end
end
