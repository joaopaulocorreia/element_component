# frozen_string_literal: true

module ElementComponent
  module Components
    class Container < Element
      VALID_BREAKPOINTS = %i[sm md lg xl xxl].freeze

      def initialize(content = nil, fluid: false, breakpoint: nil, **attributes, &)
        super("div", content, **attributes, &)

        if fluid
          add_attribute(class: "container-fluid")
        elsif breakpoint && VALID_BREAKPOINTS.include?(breakpoint)
          add_attribute(class: "container-#{breakpoint}")
        else
          add_attribute(class: "container")
        end
      end
    end
  end
end
