# frozen_string_literal: true

module ElementComponent
  module Components
    class Spinner < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze
      VALID_TYPES = %i[border grow].freeze

      def initialize(content = nil, type: :border, variant: nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "spinner-#{type}")
        add_attribute(class: "text-#{variant}") if variant
        add_attribute(role: "status")
      end
    end
  end
end
