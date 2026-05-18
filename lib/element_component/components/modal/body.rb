# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalBody < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "modal-body")
      end
    end
  end
end
