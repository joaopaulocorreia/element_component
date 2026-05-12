# frozen_string_literal: true

module ElementComponent
  module Components
    class Badge < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(content = nil, variant: :primary, pill: false, **attributes, &block)
        super("span", &block)

        add_attribute(class: "badge")
        add_attribute(class: "bg-#{variant}")
        add_attribute(class: "rounded-pill") if pill
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end
    end
  end
end
