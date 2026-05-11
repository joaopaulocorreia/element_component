# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Button
# =============================================================================
btn = ElementComponent::Components::Button.new(variant: :primary)
btn.add_content("Click Me")
puts "=== Basic Button ==="
puts btn.render
puts

# =============================================================================
# Outline Button
# =============================================================================
btn = ElementComponent::Components::Button.new(variant: :danger, outline: true)
btn.add_content("Delete")
puts "=== Outline Button ==="
puts btn.render
puts

# =============================================================================
# Size Variants
# =============================================================================
btn_lg = ElementComponent::Components::Button.new(variant: :success, size: :lg)
btn_lg.add_content("Large Button")

btn_sm = ElementComponent::Components::Button.new(variant: :secondary, size: :sm)
btn_sm.add_content("Small Button")

puts "=== Size Variants ==="
puts btn_lg.render
puts btn_sm.render
puts

# =============================================================================
# Button as Link
# =============================================================================
btn = ElementComponent::Components::Button.new(variant: :primary, href: "/home")
btn.add_content("Home")
puts "=== Button as Link ==="
puts btn.render
puts

# =============================================================================
# All Contexts
# =============================================================================
puts "=== All Button Variants ==="
ElementComponent::Components::Button::VALID_VARIANTS.each do |variant|
  btn = ElementComponent::Components::Button.new(variant: variant)
  btn.add_content(variant.to_s.capitalize)
  puts btn.render
end
puts

# =============================================================================
# Button with Block
# =============================================================================
btn = ElementComponent::Components::Button.new(variant: :info) do
  add_content("Info Button")
end
puts "=== Button with Block ==="
puts btn.render
puts

# =============================================================================
# Chained API
# =============================================================================
btn = ElementComponent::Components::Button.new(variant: :warning)
                                          .add_content("Caution")
puts "=== Chained API ==="
puts btn.render
puts

# =============================================================================
# Button with Custom Attributes
# =============================================================================
btn = ElementComponent::Components::Button.new(
  variant: :dark,
  id: "btn-submit",
  data: { action: "submit" }
)
btn.add_content("Submit")
puts "=== Button with Custom Attributes ==="
puts btn.render
