# frozen_string_literal: true

module ElementComponent
  module Components
    class CardBody < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "card-body")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
