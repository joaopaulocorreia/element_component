# frozen_string_literal: true

module ElementComponent
  module Components
    module Breadcrumb
      class Breadcrumb < Element
        def initialize(content = nil, **attributes, &)
          super("nav", content, **attributes, &)

          add_attribute("aria-label": "breadcrumb")
        end
      end
    end
  end
end
