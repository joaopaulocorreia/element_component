# frozen_string_literal: true

module ElementComponent
  module Components
    class CardText < Element
      def initialize(**attributes, &)
        super("p", &)

        add_attribute(class: "card-text")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
