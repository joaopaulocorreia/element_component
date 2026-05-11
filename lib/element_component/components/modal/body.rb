# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalBody < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "modal-body")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
