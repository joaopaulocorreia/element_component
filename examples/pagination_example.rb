# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Pagination
# =============================================================================
pager = ElementComponent::Components::Pagination.new do |p|
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("1") })
  p.add_content(ElementComponent::Components::PageItem.new(active: true) { |item| item.add_content("2") })
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("3") })
end
puts "=== Basic Pagination ==="
puts pager.render
puts

# =============================================================================
# Pagination with Previous/Next
# =============================================================================
pager = ElementComponent::Components::Pagination.new do |p|
  p.add_content(ElementComponent::Components::PageItem.new(disabled: true) { |item| item.add_content("Previous") })
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("1") })
  p.add_content(ElementComponent::Components::PageItem.new(active: true) { |item| item.add_content("2") })
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("3") })
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("Next") })
end
puts "=== Pagination with Previous/Next ==="
puts pager.render
puts

# =============================================================================
# Pagination Sizes
# =============================================================================
pager_sm = ElementComponent::Components::Pagination.new(size: :sm) do |p|
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("1") })
  p.add_content(ElementComponent::Components::PageItem.new(active: true) { |item| item.add_content("2") })
end
puts "=== Small Pagination ==="
puts pager_sm.render
puts

pager_lg = ElementComponent::Components::Pagination.new(size: :lg) do |p|
  p.add_content(ElementComponent::Components::PageItem.new { |item| item.add_content("1") })
  p.add_content(ElementComponent::Components::PageItem.new(active: true) { |item| item.add_content("2") })
end
puts "=== Large Pagination ==="
puts pager_lg.render
