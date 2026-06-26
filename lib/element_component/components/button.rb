# frozen_string_literal: true

module ElementComponent
  module Components
    class Button < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark link].freeze
      VALID_SIZES = %i[sm lg].freeze

      def initialize(content = nil, variant: :primary, type: :button, outline: false, size: nil, href: nil, **attributes, &)
        validate_option!(variant, VALID_VARIANTS, "variant")
        validate_option!(size, VALID_SIZES, "size")

        if href
          super("a", content, **attributes, &)
          add_attribute(href:)
        else
          super("button", content, **attributes, &)
          add_attribute(type:)
        end

        add_attribute(class: "btn")
        add_attribute(class: outline ? "btn-outline-#{variant}" : "btn-#{variant}")
        add_attribute(class: "btn-#{size}") if size
      end
    end
  end
end
