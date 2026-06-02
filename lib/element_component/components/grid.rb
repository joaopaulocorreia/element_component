# frozen_string_literal: true

module ElementComponent
  module Components
    class Grid < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "container")
      end
    end
  end
end
