# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Pagination
# =============================================================================
pager = ElementComponent::Components::Pagination.new do
  add_content(ElementComponent::Components::PageItem.new { add_content("1") })
  add_content(ElementComponent::Components::PageItem.new(active: true) { add_content("2") })
  add_content(ElementComponent::Components::PageItem.new { add_content("3") })
end
puts "=== Basic Pagination ==="
puts pager.render
puts

# =============================================================================
# Pagination with Previous/Next
# =============================================================================
pager = ElementComponent::Components::Pagination.new do
  add_content(ElementComponent::Components::PageItem.new(disabled: true) { add_content("Previous") })
  add_content(ElementComponent::Components::PageItem.new { add_content("1") })
  add_content(ElementComponent::Components::PageItem.new(active: true) { add_content("2") })
  add_content(ElementComponent::Components::PageItem.new { add_content("3") })
  add_content(ElementComponent::Components::PageItem.new { add_content("Next") })
end
puts "=== Pagination with Previous/Next ==="
puts pager.render
puts

# =============================================================================
# Pagination Sizes
# =============================================================================
pager_sm = ElementComponent::Components::Pagination.new(size: :sm) do
  add_content(ElementComponent::Components::PageItem.new { add_content("1") })
  add_content(ElementComponent::Components::PageItem.new(active: true) { add_content("2") })
end
puts "=== Small Pagination ==="
puts pager_sm.render
puts

pager_lg = ElementComponent::Components::Pagination.new(size: :lg) do
  add_content(ElementComponent::Components::PageItem.new { add_content("1") })
  add_content(ElementComponent::Components::PageItem.new(active: true) { add_content("2") })
end
puts "=== Large Pagination ==="
puts pager_lg.render
