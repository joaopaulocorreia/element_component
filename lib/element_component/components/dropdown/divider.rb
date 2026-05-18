# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownDivider < Element
      def initialize(**attributes)
        super("li", **attributes)

        add_content Element.new("hr", class: "dropdown-divider")
      end
    end
  end
end
