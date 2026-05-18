# frozen_string_literal: true

module ElementComponent
  module Components
    class ButtonGroup < Element
      VALID_SIZES = %i[sm lg].freeze

      def initialize(content = nil, size: nil, vertical: false, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: vertical ? "btn-group-vertical" : "btn-group")
        add_attribute(class: "btn-group-#{size}") if size
        add_attribute(role: "group")
      end
    end
  end
end
