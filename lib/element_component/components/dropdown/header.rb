# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownHeader < Element
      def initialize(**attributes, &)
        super("li", &)

        inner = Element.new("h6", class: "dropdown-header", **attributes)
        @inner_header = inner
      end

      private

      def mount_content
        inner = super
        @inner_header&.add_content(inner)
        "<li>#{@inner_header&.render}</li>"
      end
    end
  end
end
