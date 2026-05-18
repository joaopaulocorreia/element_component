# frozen_string_literal: true

require_relative "list_group/item"

module ElementComponent
  module Components
    class ListGroup < Element
      def initialize(content = nil, flush: false, numbered: false, **attributes, &)
        super("ul", content, **attributes, &)

        add_attribute(class: "list-group")
        add_attribute(class: "list-group-flush") if flush
        add_attribute(class: "list-group-numbered") if numbered
      end
    end
  end
end
