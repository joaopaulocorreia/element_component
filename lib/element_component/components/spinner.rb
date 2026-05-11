# frozen_string_literal: true

module ElementComponent
  module Components
    class Spinner < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze
      VALID_TYPES = %i[border grow].freeze

      def initialize(type: :border, variant: nil, **attributes, &block)
        super("div", &block)

        add_attribute(class: "spinner-#{type}")
        add_attribute(class: "text-#{variant}") if variant
        add_attribute(role: "status")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
