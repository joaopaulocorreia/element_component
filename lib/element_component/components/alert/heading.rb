# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertHeading < Element
      def initialize(content = nil, **attributes)
        super("h4", content, **attributes)

        add_attribute(class: "alert-heading")
      end
    end
  end
end
