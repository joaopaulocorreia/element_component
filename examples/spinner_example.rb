# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Border Spinner
# =============================================================================
spinner = ElementComponent::Components::Spinner.new
puts "=== Basic Border Spinner ==="
puts spinner.render
puts

# =============================================================================
# Grow Spinner
# =============================================================================
spinner = ElementComponent::Components::Spinner.new(type: :grow)
puts "=== Grow Spinner ==="
puts spinner.render
puts

# =============================================================================
# Color Variants
# =============================================================================
puts "=== Color Variants ==="
%i[primary secondary success danger warning info light dark].each do |variant|
  spinner = ElementComponent::Components::Spinner.new(variant: variant)
  puts spinner.render
end
puts

# =============================================================================
# Spinner with Screen Reader Text
# =============================================================================
spinner = ElementComponent::Components::Spinner.new do |s|
  s.add_content(ElementComponent::Element.new("span", class: "visually-hidden") { |e| e.add_content("Loading...") })
end
puts "=== Spinner with Text ==="
puts spinner.render
puts

# =============================================================================
# Spinner with Custom Attributes
# =============================================================================
spinner = ElementComponent::Components::Spinner.new(
  variant: :primary,
  style: "width: 3rem; height: 3rem;"
)
puts "=== Spinner with Custom Attributes ==="
puts spinner.render
