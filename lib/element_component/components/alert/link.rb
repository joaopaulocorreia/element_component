# frozen_string_literal: true

module ElementComponent
  module Components
    class AlertLink < Element
      def initialize(content = nil, **attributes)
        super("a", content, **attributes)

        add_attribute(class: "alert-link")
      end
    end
  end
end
