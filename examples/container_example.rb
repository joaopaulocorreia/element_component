# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Container
# =============================================================================
container = ElementComponent::Components::Container.new
container.add_content("Default container")
puts "=== Basic Container ==="
puts container.render
puts

# =============================================================================
# Fluid Container
# =============================================================================
container = ElementComponent::Components::Container.new(fluid: true)
container.add_content("Full-width container")
puts "=== Fluid Container ==="
puts container.render
puts

# =============================================================================
# Responsive Breakpoint Container
# =============================================================================
puts "=== Breakpoint Containers ==="
%i[sm md lg xl xxl].each do |breakpoint|
  container = ElementComponent::Components::Container.new(breakpoint: breakpoint)
  puts container.render
end
puts

# =============================================================================
# Container > Row > Columns (composed layout)
# =============================================================================
container = ElementComponent::Components::Container.new do |c|
  c.add_content(
    ElementComponent::Components::Row.new(gutter: 3) do |row|
      row.add_content(ElementComponent::Components::Col.new(col: 8) { |col| col.add_content("Main") })
      row.add_content(ElementComponent::Components::Col.new(col: 4) { |col| col.add_content("Sidebar") })
    end
  )
end
puts "=== Container with Row and Columns ==="
puts container.render
