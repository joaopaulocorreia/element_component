# frozen_string_literal: true

module ElementComponent
  module Components
    class ProgressBar < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(content = nil, value: 0, variant: nil, striped: false, animated: false, **attributes, &block)
        super("div", content, **attributes, &block)

        add_attribute(class: "progress-bar")
        add_attribute(class: "bg-#{variant}") if variant
        add_attribute(class: "progress-bar-striped") if striped
        add_attribute(class: "progress-bar-animated") if animated
        add_attribute(role: "progressbar")
        add_attribute("aria-valuenow": value.to_s)
        add_attribute("aria-valuemin": "0")
        add_attribute("aria-valuemax": "100")
        add_attribute(style: "width: #{value}%")
      end
    end
  end
end
