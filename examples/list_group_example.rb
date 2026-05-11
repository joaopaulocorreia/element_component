# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic List Group
# =============================================================================
group = ElementComponent::Components::ListGroup.new do |g|
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Item 1") })
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Item 2") })
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Item 3") })
end
puts "=== Basic List Group ==="
puts group.render
puts

# =============================================================================
# Flush List Group
# =============================================================================
group = ElementComponent::Components::ListGroup.new(flush: true) do |g|
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Flush Item 1") })
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Flush Item 2") })
end
puts "=== Flush List Group ==="
puts group.render
puts

# =============================================================================
# Active and Disabled Items
# =============================================================================
group = ElementComponent::Components::ListGroup.new do |g|
  g.add_content(ElementComponent::Components::ListGroupItem.new(active: true) do |item|
    item.add_content("Active Item")
  end)
  g.add_content(ElementComponent::Components::ListGroupItem.new { |item| item.add_content("Regular Item") })
  g.add_content(ElementComponent::Components::ListGroupItem.new(disabled: true) do |item|
    item.add_content("Disabled Item")
  end)
end
puts "=== Active and Disabled Items ==="
puts group.render
puts

# =============================================================================
# List Group with Links
# =============================================================================
group = ElementComponent::Components::ListGroup.new do |g|
  g.add_content(ElementComponent::Components::ListGroupItem.new(href: "/page1") { |item| item.add_content("Link 1") })
  g.add_content(ElementComponent::Components::ListGroupItem.new(href: "/page2") { |item| item.add_content("Link 2") })
end
puts "=== List Group with Links ==="
puts group.render
puts

# =============================================================================
# Variant Items
# =============================================================================
group = ElementComponent::Components::ListGroup.new do |g|
  g.add_content(ElementComponent::Components::ListGroupItem.new(variant: :success) do |item|
    item.add_content("Success")
  end)
  g.add_content(ElementComponent::Components::ListGroupItem.new(variant: :danger) { |item| item.add_content("Danger") })
  g.add_content(ElementComponent::Components::ListGroupItem.new(variant: :warning) do |item|
    item.add_content("Warning")
  end)
end
puts "=== Variant Items ==="
puts group.render
