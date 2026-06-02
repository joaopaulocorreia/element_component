# frozen_string_literal: true

module ElementComponent
  module Components
    class Col < Element
      VALID_BREAKPOINTS = %i[sm md lg xl xxl].freeze

      def initialize(content = nil, size: nil, breakpoint: nil, offset: nil, order: nil, **attributes, &)
        super("div", content, **attributes, &)

        if breakpoint && VALID_BREAKPOINTS.include?(breakpoint)
          add_attribute(class: size ? "col-#{breakpoint}-#{size}" : "col-#{breakpoint}")
        elsif size
          add_attribute(class: "col-#{size}")
        else
          add_attribute(class: "col")
        end

        add_attribute(class: "offset-#{offset}") if offset
        add_attribute(class: "order-#{order}") if order
      end
    end
  end
end
