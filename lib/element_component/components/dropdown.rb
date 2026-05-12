# frozen_string_literal: true

require_relative "dropdown/menu"
require_relative "dropdown/item"
require_relative "dropdown/divider"
require_relative "dropdown/header"

module ElementComponent
  module Components
    class Dropdown < Element
      VALID_DIRECTIONS = %i[dropup dropend dropstart].freeze

      def initialize(content = nil, direction: nil, **attributes, &block)
        super("div", &block)

        add_attribute(class: "dropdown")
        add_attribute(class: direction.to_s) if direction
        add_attribute(attributes) unless attributes.empty?
        add_content(content) if content
      end

      def toggle_button(label: "Dropdown", variant: :secondary, split: false, **btn_attributes, &block)
        if split
          split_btn = Button.new(variant: variant, class: "dropdown-toggle dropdown-toggle-split",
                                 **btn_attributes)
          split_btn.add_content(
            Element.new("span", class: "visually-hidden") { add_content("Toggle dropdown") }
          )
          add_content(ButtonGroup.new do
            add_content(Button.new(variant: variant, **btn_attributes) { add_content(label) })
            add_content(split_btn)
          end)
        else
          btn = Element.new("button", "aria-expanded": "false", "data-bs-toggle": "dropdown",
                                      class: "btn btn-#{variant} dropdown-toggle", type: "button", **btn_attributes)
          btn.add_content(label) if label
          block&.call(self)
          add_content(btn)
        end
        self
      end
    end
  end
end
