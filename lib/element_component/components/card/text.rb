# frozen_string_literal: true

module ElementComponent
  module Components
    class CardText < Element
      def initialize(content = nil, **attributes, &)
        super("p", content, **attributes, &)

        add_attribute(class: "card-text")
      end
    end
  end
end
