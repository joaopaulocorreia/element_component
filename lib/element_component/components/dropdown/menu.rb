# frozen_string_literal: true

module ElementComponent
  module Components
    class DropdownMenu < Element
      VALID_ALIGNS = %i[start end].freeze

      def initialize(content = nil, align: nil, **attributes)
        super("ul", content, **attributes)

        add_attribute(class: "dropdown-menu")
        add_attribute(class: "dropdown-menu-#{align}") if align
      end
    end
  end
end
