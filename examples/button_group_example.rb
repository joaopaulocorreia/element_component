# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Button Group
# =============================================================================
group = ElementComponent::Components::ButtonGroup.new
group.add_content(
  ElementComponent::Components::Button.new(variant: :primary).add_content("Left")
)
group.add_content(
  ElementComponent::Components::Button.new(variant: :primary).add_content("Middle")
)
group.add_content(
  ElementComponent::Components::Button.new(variant: :primary).add_content("Right")
)
puts "=== Basic Button Group ==="
puts group.render
puts

# =============================================================================
# Vertical Button Group
# =============================================================================
group = ElementComponent::Components::ButtonGroup.new(vertical: true)
group.add_content(
  ElementComponent::Components::Button.new(variant: :secondary).add_content("Top")
)
group.add_content(
  ElementComponent::Components::Button.new(variant: :secondary).add_content("Bottom")
)
puts "=== Vertical Button Group ==="
puts group.render
puts

# =============================================================================
# Button Group with Size
# =============================================================================
group = ElementComponent::Components::ButtonGroup.new(size: :sm) do |g|
  g.add_content(ElementComponent::Components::Button.new(variant: :success) { |b| b.add_content("Save") })
  g.add_content(ElementComponent::Components::Button.new(variant: :danger) { |b| b.add_content("Delete") })
end
puts "=== Small Button Group ==="
puts group.render
puts

# =============================================================================
# Chained API
# =============================================================================
group = ElementComponent::Components::ButtonGroup.new(class: "my-group")
group.add_content(
  ElementComponent::Components::Button.new(variant: :info).add_content("Action")
)
puts "=== Button Group with Custom Class ==="
puts group.render
