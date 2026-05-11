# frozen_string_literal: true

module ElementComponent
  module Components
    class CardTitle < Element
      def initialize(**attributes, &)
        super("h5", &)

        add_attribute(class: "card-title")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
