# frozen_string_literal: true

require_relative "alert/heading"
require_relative "alert/link"
require_relative "alert/close_button"

module ElementComponent
  module Components
    class Alert < Element
      VALID_CONTEXTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(context: :primary, dismissible: false, **attributes, &block)
        super("div")

        add_attribute(class: "alert")
        add_attribute(class: "alert-#{context}")
        add_attribute(class: "alert-dismissible") if dismissible
        add_attribute(role: "alert")

        attributes.each { |key, value| add_attribute(key => value) }

        instance_eval(&block) if block
        add_content(AlertCloseButton.new) if dismissible
      end
    end
  end
end
