# frozen_string_literal: true

module ElementComponent
  module Components
    class CarouselItem < Element
      def initialize(active: false, interval: nil, **attributes, &block)
        super("div", &block)

        add_attribute(class: "carousel-item")
        add_attribute(class: "active") if active
        add_attribute("data-bs-interval": interval.to_s) if interval
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
