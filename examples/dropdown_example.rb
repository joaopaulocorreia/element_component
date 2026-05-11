# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Dropdown
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do
  add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-secondary dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do
      add_content("Dropdown")
    end
  )
  add_content(
    ElementComponent::Components::DropdownMenu.new do
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Action") })
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Another action") })
      add_content(ElementComponent::Components::DropdownDivider.new)
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Something else") })
    end
  )
end
puts "=== Basic Dropdown ==="
puts dropdown.render
puts

# =============================================================================
# Dropdown with Active and Disabled Items
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do
  add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-primary dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do
      add_content("Menu")
    end
  )
  add_content(
    ElementComponent::Components::DropdownMenu.new do
      add_content(ElementComponent::Components::DropdownHeader.new { add_content("Section 1") })
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Regular item") })
      add_content(ElementComponent::Components::DropdownItem.new(active: true) { add_content("Active item") })
      add_content(ElementComponent::Components::DropdownItem.new(disabled: true) { add_content("Disabled item") })
    end
  )
end
puts "=== Dropdown with States ==="
puts dropdown.render
puts

# =============================================================================
# Dropdown Type Button Items
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do
  add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-success dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do
      add_content("Actions")
    end
  )
  add_content(
    ElementComponent::Components::DropdownMenu.new do
      add_content(ElementComponent::Components::DropdownItem.new(type: :button) { add_content("Save") })
      add_content(ElementComponent::Components::DropdownItem.new(type: :button) { add_content("Delete") })
    end
  )
end
puts "=== Dropdown with Button Items ==="
puts dropdown.render
puts

# =============================================================================
# Dropup Direction
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new(direction: :dropup) do
  add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-warning dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do
      add_content("Up")
    end
  )
  add_content(
    ElementComponent::Components::DropdownMenu.new do
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Item 1") })
      add_content(ElementComponent::Components::DropdownItem.new { add_content("Item 2") })
    end
  )
end
puts "=== Dropup ==="
puts dropdown.render
puts

# =============================================================================
# Sub-Components Rendered Independently
# =============================================================================
puts "=== DropdownMenu ==="
puts ElementComponent::Components::DropdownMenu.new.render
puts

puts "=== DropdownItem ==="
dropdown_item = ElementComponent::Components::DropdownItem.new { add_content("Item") }
puts dropdown_item.render
puts

puts "=== DropdownDivider ==="
puts ElementComponent::Components::DropdownDivider.new.render
puts

puts "=== DropdownHeader ==="
dropdown_header = ElementComponent::Components::DropdownHeader.new { add_content("Header") }
puts dropdown_header.render
