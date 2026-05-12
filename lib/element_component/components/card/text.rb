# frozen_string_literal: true

module ElementComponent
  module Components
    class CardText < Element
      def initialize(content = nil, **attributes, &)
        super("p", &)

        add_attribute(class: "card-text")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
