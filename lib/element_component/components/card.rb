# frozen_string_literal: true

require_relative "card/header"
require_relative "card/body"
require_relative "card/footer"
require_relative "card/title"
require_relative "card/text"
require_relative "card/image"

module ElementComponent
  module Components
    class Card < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "card")
      end
    end
  end
end
