# frozen_string_literal: true

module ElementComponent
  module Components
    class Badge < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(content = nil, variant: :primary, pill: false, **attributes, &)
        super("span", content, **attributes, &)

        add_attribute(class: "badge")
        add_attribute(class: "text-bg-#{variant}")
        add_attribute(class: "rounded-pill") if pill
      end
    end
  end
end
