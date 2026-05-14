# frozen_string_literal: true

require_relative "modal/dialog"
require_relative "modal/content"
require_relative "modal/header"
require_relative "modal/title"
require_relative "modal/body"
require_relative "modal/footer"

module ElementComponent
  module Components
    class Modal < Element
      VALID_SIZES = %i[sm lg xl].freeze
      VALID_FULLSCREEN = %i[always sm md lg xl xxl].freeze

      def initialize(fade: true, static: false, scrollable: false, centered: false, size: nil, fullscreen: nil,
                     **attributes, &block)
        super("div", &block)

        add_attribute(class: "modal")
        add_attribute(class: "fade") if fade
        add_attribute(tabindex: "-1")
        add_attribute("aria-hidden": "true")
        add_attribute("data-bs-backdrop": "static") if static
        add_attribute("data-bs-keyboard": "false") if static

        add_content(ModalDialog.new(scrollable: scrollable, centered: centered, size: size, fullscreen: fullscreen))
        add_attribute(attributes) unless attributes.empty?
      end

      private

      def build
        @html << opening_tag
        @html << mount_content(contents)
        @html << closing_tag
        @html
      end
    end
  end
end
