# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownHeader < Element
      def initialize(content = nil, **attributes)
        super("li", **attributes)

        add_content Element.new("h6", content, class: "dropdown-header")
      end
    end
  end
end
