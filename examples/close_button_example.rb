# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Close Button
# =============================================================================
btn = ElementComponent::Components::CloseButton.new
puts "=== Basic Close Button ==="
puts btn.render
puts

# =============================================================================
# Disabled Close Button
# =============================================================================
btn = ElementComponent::Components::CloseButton.new(disabled: true)
puts "=== Disabled Close Button ==="
puts btn.render
puts

# =============================================================================
# Close Button with Custom Attributes
# =============================================================================
btn = ElementComponent::Components::CloseButton.new(
  class: "custom-close",
  id: "close-btn-1",
  data: { dismiss: "modal" }
)
puts "=== Close Button with Custom Attributes ==="
puts btn.render
puts

# =============================================================================
# Close Button Inside an Alert (simulated)
# =============================================================================
alert = ElementComponent::Components::Alert.new(variant: :warning, dismissible: true) do
  add_content("This alert has a close button.")
end
puts "=== Close Button Inside Alert ==="
puts alert.render
