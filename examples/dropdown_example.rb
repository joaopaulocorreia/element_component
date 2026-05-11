# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Dropdown
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do |d|
  d.add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-secondary dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do |btn|
      btn.add_content("Dropdown")
    end
  )
  d.add_content(
    ElementComponent::Components::DropdownMenu.new do |menu|
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Action") })
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Another action") })
      menu.add_content(ElementComponent::Components::DropdownDivider.new)
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Something else") })
    end
  )
end
puts "=== Basic Dropdown ==="
puts dropdown.render
puts

# =============================================================================
# Dropdown with Active and Disabled Items
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do |d|
  d.add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-primary dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do |btn|
      btn.add_content("Menu")
    end
  )
  d.add_content(
    ElementComponent::Components::DropdownMenu.new do |menu|
      menu.add_content(ElementComponent::Components::DropdownHeader.new { |h| h.add_content("Section 1") })
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Regular item") })
      menu.add_content(ElementComponent::Components::DropdownItem.new(active: true) do |item|
        item.add_content("Active item")
      end)
      menu.add_content(ElementComponent::Components::DropdownItem.new(disabled: true) do |item|
        item.add_content("Disabled item")
      end)
    end
  )
end
puts "=== Dropdown with States ==="
puts dropdown.render
puts

# =============================================================================
# Dropdown Type Button Items
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new do |d|
  d.add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-success dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do |btn|
      btn.add_content("Actions")
    end
  )
  d.add_content(
    ElementComponent::Components::DropdownMenu.new do |menu|
      menu.add_content(ElementComponent::Components::DropdownItem.new(type: :button) do |item|
        item.add_content("Save")
      end)
      menu.add_content(ElementComponent::Components::DropdownItem.new(type: :button) do |item|
        item.add_content("Delete")
      end)
    end
  )
end
puts "=== Dropdown with Button Items ==="
puts dropdown.render
puts

# =============================================================================
# Dropup Direction
# =============================================================================
dropdown = ElementComponent::Components::Dropdown.new(direction: :dropup) do |d|
  d.add_content(
    ElementComponent::Element.new("button",
                                  class: "btn btn-warning dropdown-toggle",
                                  type: "button",
                                  "data-bs-toggle": "dropdown",
                                  "aria-expanded": "false") do |btn|
      btn.add_content("Up")
    end
  )
  d.add_content(
    ElementComponent::Components::DropdownMenu.new do |menu|
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Item 1") })
      menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Item 2") })
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
dropdown_item = ElementComponent::Components::DropdownItem.new { |item| item.add_content("Item") }
puts dropdown_item.render
puts

puts "=== DropdownDivider ==="
puts ElementComponent::Components::DropdownDivider.new.render
puts

puts "=== DropdownHeader ==="
dropdown_header = ElementComponent::Components::DropdownHeader.new { |h| h.add_content("Header") }
puts dropdown_header.render
