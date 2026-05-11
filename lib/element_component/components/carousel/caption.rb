# frozen_string_literal: true

module ElementComponent
  module Components
    class CarouselCaption < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "carousel-caption")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
