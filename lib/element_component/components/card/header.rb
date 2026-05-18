# frozen_string_literal: true

module ElementComponent
  module Components
    class CardHeader < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "card-header")
      end
    end
  end
end
