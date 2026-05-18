# frozen_string_literal: true

module ElementComponent
  module Components
    class CardBody < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "card-body")
      end
    end
  end
end
