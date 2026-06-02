# frozen_string_literal: true

module ElementComponent
  module Components
    class Col < Element
      VALID_BREAKPOINTS = %i[sm md lg xl xxl].freeze

      def initialize(content = nil, size: nil, breakpoint: nil, offset: nil, order: nil,
                     breakpoints: {}, offsets: {}, orders: {}, **attributes, &)
        super("div", content, **attributes, &)

        add_col_classes(size: size, breakpoint: breakpoint, breakpoints: breakpoints)
        add_offset_classes(offset: offset, offsets: offsets)
        add_order_classes(order: order, orders: orders)
      end

      private

      def add_col_classes(size:, breakpoint:, breakpoints:)
        return add_breakpoint_classes(breakpoints) if breakpoints.any?

        if breakpoint && VALID_BREAKPOINTS.include?(breakpoint)
          add_attribute(class: size ? "col-#{breakpoint}-#{size}" : "col-#{breakpoint}")
        elsif size
          add_attribute(class: "col-#{size}")
        else
          add_attribute(class: "col")
        end
      end

      def add_breakpoint_classes(breakpoints)
        breakpoints.each do |bp, sz|
          if bp.nil?
            add_attribute(class: sz ? "col-#{sz}" : "col")
          elsif VALID_BREAKPOINTS.include?(bp)
            add_attribute(class: sz ? "col-#{bp}-#{sz}" : "col-#{bp}")
          end
        end
      end

      def add_offset_classes(offset:, offsets:)
        if offsets.any?
          offsets.each do |bp, off|
            add_attribute(class: bp.nil? ? "offset-#{off}" : "offset-#{bp}-#{off}")
          end
        elsif offset
          add_attribute(class: "offset-#{offset}")
        end
      end

      def add_order_classes(order:, orders:)
        if orders.any?
          orders.each do |bp, ord|
            add_attribute(class: bp.nil? ? "order-#{ord}" : "order-#{bp}-#{ord}")
          end
        elsif order
          add_attribute(class: "order-#{order}")
        end
      end
    end
  end
end
