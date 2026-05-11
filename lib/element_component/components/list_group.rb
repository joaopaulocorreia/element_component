# frozen_string_literal: true

require_relative "list_group/item"

module ElementComponent
  module Components
    class ListGroup < Element
      def initialize(flush: false, numbered: false, **attributes, &block)
        super("ul", &block)

        add_attribute(class: "list-group")
        add_attribute(class: "list-group-flush") if flush
        add_attribute(class: "list-group-numbered") if numbered
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
