# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Badge
# =============================================================================
badge = ElementComponent::Components::Badge.new(variant: :primary)
badge.add_content("New")
puts "=== Basic Badge ==="
puts badge.render
puts

# =============================================================================
# Pill Badge
# =============================================================================
badge = ElementComponent::Components::Badge.new(variant: :danger, pill: true)
badge.add_content("99+")
puts "=== Pill Badge ==="
puts badge.render
puts

# =============================================================================
# All Contexts
# =============================================================================
puts "=== All Badge Variants ==="
ElementComponent::Components::Badge::VALID_VARIANTS.each do |variant|
  badge = ElementComponent::Components::Badge.new(variant: variant)
  badge.add_content(variant.to_s.capitalize)
  puts badge.render
end
puts

# =============================================================================
# Badge with Block
# =============================================================================
badge = ElementComponent::Components::Badge.new(variant: :success) do |b|
  b.add_content("Completed")
end
puts "=== Badge with Block ==="
puts badge.render
puts

# =============================================================================
# Chained API
# =============================================================================
badge = ElementComponent::Components::Badge.new(variant: :warning)
                                           .add_content("Warning")
puts "=== Chained API ==="
puts badge.render
puts

# =============================================================================
# Badge with Custom Attributes
# =============================================================================
badge = ElementComponent::Components::Badge.new(
  variant: :info,
  id: "badge-1",
  style: "font-size: 1.2em;"
)
badge.add_content("Custom")
puts "=== Badge with Custom Attributes ==="
puts badge.render
