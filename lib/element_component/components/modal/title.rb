# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalTitle < Element
      def initialize(**attributes, &)
        super("h5", &)

        add_attribute(class: "modal-title")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
