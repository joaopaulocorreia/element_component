# frozen_string_literal: true

module ElementComponent
  module Components
    class CardFooter < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "card-footer")
      end
    end
  end
end
