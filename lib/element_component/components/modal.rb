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
      def initialize(content = nil, fade: true, static: false, **attributes)
        super("div", content, **attributes)

        add_attribute(class: "modal")
        add_attribute(class: "fade") if fade
        add_attribute(tabindex: "-1")
        add_attribute("aria-hidden": "true")
        add_attribute("data-bs-backdrop": "static") if static
        add_attribute("data-bs-keyboard": "false") if static
      end
    end
  end
end
