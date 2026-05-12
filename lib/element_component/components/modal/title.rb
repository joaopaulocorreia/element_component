# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalTitle < Element
      def initialize(content = nil, **attributes, &)
        super("h5", &)

        add_attribute(class: "modal-title")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
