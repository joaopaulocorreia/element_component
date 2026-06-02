# frozen_string_literal: true

module ElementComponent
  module Components
    class Row < Element
      def initialize(content = nil, cols: nil, gutter: nil, gutter_x: nil, gutter_y: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "row")
        add_attribute(class: "row-cols-#{cols}") if cols
        add_attribute(class: "g-#{gutter}") if gutter
        add_attribute(class: "gx-#{gutter_x}") if gutter_x
        add_attribute(class: "gy-#{gutter_y}") if gutter_y
      end
    end
  end
end
