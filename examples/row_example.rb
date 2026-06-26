# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Row
# =============================================================================
row = ElementComponent::Components::Row.new
puts "=== Basic Row ==="
puts row.render
puts

# =============================================================================
# Row with a Fixed Number of Columns
# =============================================================================
row = ElementComponent::Components::Row.new(cols: 3)
puts "=== Row with cols: 3 ==="
puts row.render
puts

# =============================================================================
# Row with Responsive Columns (hash breakpoints)
# =============================================================================
row = ElementComponent::Components::Row.new(cols: { default: 1, md: 2, lg: 4 })
puts "=== Row with responsive cols ==="
puts row.render
puts

# =============================================================================
# Row with Gutters
# =============================================================================
row = ElementComponent::Components::Row.new(gutter: 3)
puts "=== Row with gutter: 3 ==="
puts row.render

row = ElementComponent::Components::Row.new(gutter_x: 5, gutter_y: 2)
puts "=== Row with horizontal/vertical gutters ==="
puts row.render
puts

# =============================================================================
# Row with Columns Inside
# =============================================================================
row = ElementComponent::Components::Row.new(cols: 2) do |r|
  r.add_content(ElementComponent::Components::Col.new { |c| c.add_content("Column one") })
  r.add_content(ElementComponent::Components::Col.new { |c| c.add_content("Column two") })
end
puts "=== Row with Columns ==="
puts row.render
