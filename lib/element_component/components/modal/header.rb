# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalHeader < Element
      def initialize(content = nil, close_button: true, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "modal-header")

        add_content(CloseButton.new) if close_button
      end
    end
  end
end
