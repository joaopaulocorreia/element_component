# frozen_string_literal: true

module ElementComponent
  module Components
    class CardHeader < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "card-header")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
