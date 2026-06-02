# frozen_string_literal: true

module ElementComponent
  module Components
    class Row < Element
      include BreakpointHelper

      def initialize(content = nil, cols: nil, gutter: nil, gutter_x: nil, gutter_y: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "row")
        add_classes_from_breakpoints("row-cols", cols)
        add_classes_from_breakpoints("g", gutter)
        add_classes_from_breakpoints("gx", gutter_x)
        add_classes_from_breakpoints("gy", gutter_y)
      end

      private

      def add_classes_from_breakpoints(prefix, value)
        breakpoint_classes(prefix, value).each { |klass| add_attribute(class: klass) }
      end
    end
  end
end
