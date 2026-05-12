# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalHeader < Element
      def initialize(content = nil, close_button: true, **attributes, &block)
        super("div", &block)

        add_attribute(class: "modal-header")
        add_attribute(attributes) unless attributes.empty?

        add_content(content) if content
        add_content(CloseButton.new) if close_button
      end
    end
  end
end
