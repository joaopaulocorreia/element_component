# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Table
# =============================================================================
table = ElementComponent::Components::Table.new
puts "=== Basic Table ==="
puts table.render
puts

# =============================================================================
# Table with All Options
# =============================================================================
table = ElementComponent::Components::Table.new(
  striped: true, bordered: true, hover: true, small: true, variant: :dark
)
puts "=== Table with All Options ==="
puts table.render
puts

# =============================================================================
# Table with Content
# =============================================================================
table = ElementComponent::Components::Table.new(striped: true) do
  add_content("<thead><tr><th>Name</th><th>Age</th></tr></thead>")
  add_content("<tbody><tr><td>John</td><td>30</td></tr></tbody>")
end
puts "=== Table with Content ==="
puts table.render
puts

# =============================================================================
# Table Variants
# =============================================================================
puts "=== Table Variants ==="
%i[primary secondary success danger warning info light dark].each do |variant|
  t = ElementComponent::Components::Table.new(variant: variant)
  puts t.render
end
