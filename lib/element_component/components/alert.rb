# frozen_string_literal: true

require_relative "alert/heading"
require_relative "alert/link"
require_relative "alert/close_button"

module ElementComponent
  module Components
    class Alert < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(variant: :primary, dismissible: false, **attributes, &block)
        super("div", &block)

        add_attribute(class: "alert")
        add_attribute(class: "alert-#{variant}")
        add_attribute(class: "alert-dismissible") if dismissible
        add_attribute(role: "alert")

        add_attribute(attributes) unless attributes.empty?
        add_content(AlertCloseButton.new) if dismissible
      end
    end
  end
end
