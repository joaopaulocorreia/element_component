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

      private

      def apply_col_classes(col)
        if col.nil?
          add_attribute(class: "col")
        else
          breakpoint_classes("col", col).each { |klass| add_attribute(class: klass) }
        end
      end
    end
  end
end
