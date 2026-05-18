# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalContent < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "modal-content")
      end
    end
  end
end
