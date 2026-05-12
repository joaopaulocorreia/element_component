# frozen_string_literal: true

module ElementComponent
  module Components
    class ModalDialog < Element
      VALID_SIZES = %i[sm lg xl].freeze
      VALID_FULLSCREEN = %i[always sm md lg xl xxl].freeze

      def initialize(content = nil, scrollable: false, centered: false, size: nil, fullscreen: nil, **attributes, &block)
        super("div", &block)

        add_attribute(class: "modal-dialog")
        add_attribute(class: "modal-dialog-scrollable") if scrollable
        add_attribute(class: "modal-dialog-centered") if centered
        add_attribute(class: "modal-#{size}") if size
        add_attribute(class: "modal-fullscreen#{"-#{fullscreen}-down" unless fullscreen == :always}") if fullscreen
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
