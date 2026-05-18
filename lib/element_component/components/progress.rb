# frozen_string_literal: true

require_relative "progress/bar"

module ElementComponent
  module Components
    class Progress < Element
      def initialize(content = nil, **attributes, &)
        super("div", content, **attributes, &)

        add_attribute(class: "progress")
        add_attribute(role: "progressbar")
      end
    end
  end
end
