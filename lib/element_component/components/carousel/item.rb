# frozen_string_literal: true

module ElementComponent
  module Components
    class CarouselItem < Element
      def initialize(content = nil, active: false, interval: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "carousel-item")
        add_attribute(class: "active") if active
        add_attribute("data-bs-interval": interval.to_s) if interval
      end
    end
  end
end
