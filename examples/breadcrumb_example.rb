# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Breadcrumb
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new do |b|
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { |item| item.add_content("Home") })
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/library") do |item|
    item.add_content("Library")
  end)
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { |item| item.add_content("Data") })
end
puts "=== Basic Breadcrumb ==="
puts breadcrumb.render
puts

# =============================================================================
# Breadcrumb with Two Items
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new do |b|
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { |item| item.add_content("Home") })
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) do |item|
    item.add_content("Current Page")
  end)
end
puts "=== Two-Item Breadcrumb ==="
puts breadcrumb.render
puts

# =============================================================================
# Breadcrumb with Custom Class
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new(class: "custom-breadcrumb") do |b|
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { |item| item.add_content("Home") })
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { |item| item.add_content("Active") })
end
puts "=== Breadcrumb with Custom Class ==="
puts breadcrumb.render
