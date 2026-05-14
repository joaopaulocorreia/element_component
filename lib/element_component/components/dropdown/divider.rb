# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownDivider < Element
      def initialize(**attributes)
        super("li")

        inner = Element.new("hr", class: "dropdown-divider", **attributes)
        @inner_divider = inner
      end

      private

      def mount_content(_contents = nil)
        @inner_divider&.render || ""
      end
    end
  end
end
