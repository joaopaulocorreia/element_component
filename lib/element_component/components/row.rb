# frozen_string_literal: true

module ElementComponent
  module Components
    class Row < Element
      include BreakpointHelper

      def initialize(content = nil, cols: nil, gutter: nil, gutter_x: nil, gutter_y: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "row")
        apply_breakpoint_classes("row-cols", cols)
        apply_breakpoint_classes("g", gutter)
        apply_breakpoint_classes("gx", gutter_x)
        apply_breakpoint_classes("gy", gutter_y)
      end

      def cols(value)
        apply_breakpoint_classes("row-cols", value)
        self
      end

      def gutter(value)
        apply_breakpoint_classes("g", value)
        self
      end

      def gutter_x(value)
        apply_breakpoint_classes("gx", value)
        self
      end

      def gutter_y(value)
        apply_breakpoint_classes("gy", value)
        self
      end

      private

      def apply_breakpoint_classes(prefix, value)
        breakpoint_classes(prefix, value).each { |klass| add_attribute(class: klass) }
      end
    end
  end
end
