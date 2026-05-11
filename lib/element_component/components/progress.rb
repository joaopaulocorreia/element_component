# frozen_string_literal: true

require_relative "progress/bar"

module ElementComponent
  module Components
    class Progress < Element
      def initialize(**attributes, &)
        super("div", &)

        add_attribute(class: "progress")
        add_attribute(role: "progressbar")
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
