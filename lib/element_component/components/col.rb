# frozen_string_literal: true

module ElementComponent
  module Components
    class Col < Element
      include BreakpointHelper

      def initialize(content = nil, col: nil, offset: nil, order: nil, **attributes, &)
        super("div", content, **attributes, &)

        apply_col_classes(col)
        apply_breakpoint_classes("offset", offset)
        apply_breakpoint_classes("order", order)
      end

      def col(value)
        apply_col_classes(value)
        self
      end

      def offset(value)
        apply_breakpoint_classes("offset", value)
        self
      end

      def order(value)
        apply_breakpoint_classes("order", value)
        self
      end

      private

      def apply_col_classes(col)
        if col.nil?
          add_attribute(class: "col")
        else
          breakpoint_classes("col", col).each { |klass| add_attribute(class: klass) }
        end
      end

      def apply_breakpoint_classes(prefix, value)
        breakpoint_classes(prefix, value).each { |klass| add_attribute(class: klass) }
      end
    end
  end
end
