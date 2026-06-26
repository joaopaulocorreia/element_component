# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Column (auto-width)
# =============================================================================
col = ElementComponent::Components::Col.new
puts "=== Basic Column ==="
puts col.render
puts

# =============================================================================
# Column with a Fixed Width
# =============================================================================
col = ElementComponent::Components::Col.new(col: 6)
puts "=== Column with col: 6 ==="
puts col.render
puts

# =============================================================================
# Responsive Column Width (hash breakpoints)
# =============================================================================
col = ElementComponent::Components::Col.new(col: { default: 12, md: 6, lg: 4 })
puts "=== Responsive Column ==="
puts col.render
puts

# =============================================================================
# Column with Offset
# =============================================================================
col = ElementComponent::Components::Col.new(col: 4, offset: 2)
puts "=== Column with Offset ==="
puts col.render

col = ElementComponent::Components::Col.new(col: { md: 4 }, offset: { md: 2 })
puts "=== Responsive Offset ==="
puts col.render
puts

# =============================================================================
# Column with Order
# =============================================================================
col = ElementComponent::Components::Col.new(order: 1)
puts "=== Column with order: 1 ==="
puts col.render

col = ElementComponent::Components::Col.new(order: { default: 2, lg: 1 })
puts "=== Responsive Order ==="
puts col.render
