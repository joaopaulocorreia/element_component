# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Progress Bar
# =============================================================================
progress = ElementComponent::Components::Progress.new do
  add_content(ElementComponent::Components::ProgressBar.new(value: 75))
end
puts "=== Basic Progress Bar ==="
puts progress.render
puts

# =============================================================================
# Progress Bar with Variant
# =============================================================================
progress = ElementComponent::Components::Progress.new do
  add_content(ElementComponent::Components::ProgressBar.new(value: 50, variant: :info))
end
puts "=== Progress Bar with Variant ==="
puts progress.render
puts

# =============================================================================
# Striped and Animated Progress Bar
# =============================================================================
progress = ElementComponent::Components::Progress.new do
  add_content(ElementComponent::Components::ProgressBar.new(
                value: 60, variant: :warning, striped: true, animated: true
              ))
end
puts "=== Striped and Animated ==="
puts progress.render
puts

# =============================================================================
# Multiple Progress Bars
# =============================================================================
progress = ElementComponent::Components::Progress.new do
  add_content(ElementComponent::Components::ProgressBar.new(value: 30, variant: :danger))
  add_content(ElementComponent::Components::ProgressBar.new(value: 20, variant: :warning))
  add_content(ElementComponent::Components::ProgressBar.new(value: 40, variant: :success))
end
puts "=== Multiple Progress Bars ==="
puts progress.render
puts

# =============================================================================
# Standalone Progress Bar
# =============================================================================
bar = ElementComponent::Components::ProgressBar.new(value: 85, variant: :success)
puts "=== Standalone Progress Bar ==="
puts bar.render
