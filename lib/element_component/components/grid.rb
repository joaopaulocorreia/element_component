# frozen_string_literal: true

module ElementComponent
  module Components
    class Grid < Element
      include BreakpointHelper

      def initialize(content = nil, gap: nil, row_gap: nil, column_gap: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "d-grid")
        apply_breakpoint_classes("gap", gap)
        apply_breakpoint_classes("row-gap", row_gap)
        apply_breakpoint_classes("column-gap", column_gap)
      end
    end
  end
end
