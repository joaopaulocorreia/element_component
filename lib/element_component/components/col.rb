# frozen_string_literal: true

module ElementComponent
  module Components
    class Col < Element
      include BreakpointHelper

      def initialize(content = nil, col: nil, offset: nil, order: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_col_classes(col)
        add_classes_from_breakpoints("offset", offset)
        add_classes_from_breakpoints("order", order)
      end

      private

      def add_col_classes(col)
        if col.nil?
          add_attribute(class: "col")
        else
          breakpoint_classes("col", col).each { |klass| add_attribute(class: klass) }
        end
      end

      def add_classes_from_breakpoints(prefix, value)
        breakpoint_classes(prefix, value).each { |klass| add_attribute(class: klass) }
      end
    end
  end
end
