# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Grid (CSS Grid via d-grid)
# =============================================================================
grid = ElementComponent::Components::Grid.new
puts "=== Basic Grid ==="
puts grid.render
puts

# =============================================================================
# Grid with a Gap
# =============================================================================
grid = ElementComponent::Components::Grid.new(gap: 3)
puts "=== Grid with gap: 3 ==="
puts grid.render
puts

# =============================================================================
# Grid with Separate Row and Column Gaps
# =============================================================================
grid = ElementComponent::Components::Grid.new(row_gap: 2, column_gap: 4)
puts "=== Grid with row/column gaps ==="
puts grid.render
puts

# =============================================================================
# Grid with Responsive Gap (hash breakpoints)
# =============================================================================
grid = ElementComponent::Components::Grid.new(gap: { default: 2, md: 4 })
puts "=== Grid with responsive gap ==="
puts grid.render
puts

# =============================================================================
# Grid with Content
# =============================================================================
grid = ElementComponent::Components::Grid.new(gap: 3) do |g|
  g.add_content(ElementComponent::Element.new("div") { |d| d.add_content("Item 1") })
  g.add_content(ElementComponent::Element.new("div") { |d| d.add_content("Item 2") })
end
puts "=== Grid with Content ==="
puts grid.render
