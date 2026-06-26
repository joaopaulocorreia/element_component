# frozen_string_literal: true

module ElementComponent
  module Components
    class Container < Element
      include BreakpointHelper

      def initialize(content = nil, fluid: false, breakpoint: nil, **attributes, &)
        validate_option!(breakpoint, VALID_BREAKPOINTS, "breakpoint")

        super("div", content, **attributes, &)

        if fluid
          add_attribute(class: "container-fluid")
        elsif breakpoint
          add_attribute(class: "container-#{breakpoint}")
        else
          add_attribute(class: "container")
        end
      end
    end
  end
end
