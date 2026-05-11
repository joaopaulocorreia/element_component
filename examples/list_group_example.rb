# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic List Group
# =============================================================================
group = ElementComponent::Components::ListGroup.new do
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Item 1") })
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Item 2") })
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Item 3") })
end
puts "=== Basic List Group ==="
puts group.render
puts

# =============================================================================
# Flush List Group
# =============================================================================
group = ElementComponent::Components::ListGroup.new(flush: true) do
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Flush Item 1") })
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Flush Item 2") })
end
puts "=== Flush List Group ==="
puts group.render
puts

# =============================================================================
# Active and Disabled Items
# =============================================================================
group = ElementComponent::Components::ListGroup.new do
  add_content(ElementComponent::Components::ListGroupItem.new(active: true) { add_content("Active Item") })
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Regular Item") })
  add_content(ElementComponent::Components::ListGroupItem.new(disabled: true) { add_content("Disabled Item") })
end
puts "=== Active and Disabled Items ==="
puts group.render
puts

# =============================================================================
# List Group with Links
# =============================================================================
group = ElementComponent::Components::ListGroup.new do
  add_content(ElementComponent::Components::ListGroupItem.new(href: "/page1") { add_content("Link 1") })
  add_content(ElementComponent::Components::ListGroupItem.new(href: "/page2") { add_content("Link 2") })
end
puts "=== List Group with Links ==="
puts group.render
puts

# =============================================================================
# Variant Items
# =============================================================================
group = ElementComponent::Components::ListGroup.new do
  add_content(ElementComponent::Components::ListGroupItem.new(variant: :success) { add_content("Success") })
  add_content(ElementComponent::Components::ListGroupItem.new(variant: :danger) { add_content("Danger") })
  add_content(ElementComponent::Components::ListGroupItem.new(variant: :warning) { add_content("Warning") })
end
puts "=== Variant Items ==="
puts group.render
