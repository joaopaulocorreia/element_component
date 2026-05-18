# frozen_string_literal: true

module ElementComponent
  module Components
    class CardTitle < Element
      def initialize(content = nil, **attributes, &)
        super("h5", content, **attributes, &)

        add_attribute(class: "card-title")
      end
    end
  end
end
