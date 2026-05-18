# frozen_string_literal: true

module ElementComponent
  module Components
    class CardImage < Element
      def initialize(src: "", top: false, bottom: false, **attributes, &)
        super("img", closing_tag: false, **attributes, &)

        add_attribute(class: "card-img", src:)
        add_attribute(class: "card-img-top") if top
        add_attribute(class: "card-img-bottom") if bottom
      end
    end
  end
end
