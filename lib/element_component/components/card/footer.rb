# frozen_string_literal: true

module ElementComponent
  module Components
    class CardFooter < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "card-footer")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
