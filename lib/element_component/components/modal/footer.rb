# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalFooter < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "modal-footer")
      end
    end
  end
end
