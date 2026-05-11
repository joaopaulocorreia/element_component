# frozen_string_literal: true

module ElementComponent
  module Components
    class CardImage < Element
      def initialize(src: "", top: false, bottom: false, **attributes, &block)
        super("img", closing_tag: false, &block)

        add_attribute(class: "card-img")
        add_attribute(class: "card-img-top") if top
        add_attribute(class: "card-img-bottom") if bottom
        add_attribute(src: src)
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
