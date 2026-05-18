# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalTitle < Element
      def initialize(content = nil, **attributes, &)
        super("h5", content, **attributes, &)

        add_attribute(class: "modal-title")
      end
    end
  end
end
