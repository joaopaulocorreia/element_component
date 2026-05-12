# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalFooter < Element
      def initialize(content = nil, **attributes, &)
        super("div", &)

        add_attribute(class: "modal-footer")
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
