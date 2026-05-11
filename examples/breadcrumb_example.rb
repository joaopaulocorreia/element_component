# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Breadcrumb
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new do
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { add_content("Home") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/library") { add_content("Library") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { add_content("Data") })
end
puts "=== Basic Breadcrumb ==="
puts breadcrumb.render
puts

# =============================================================================
# Breadcrumb with Two Items
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new do
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { add_content("Home") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { add_content("Current Page") })
end
puts "=== Two-Item Breadcrumb ==="
puts breadcrumb.render
puts

# =============================================================================
# Breadcrumb with Custom Class
# =============================================================================
breadcrumb = ElementComponent::Components::Breadcrumb.new(class: "custom-breadcrumb") do
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { add_content("Home") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { add_content("Active") })
end
puts "=== Breadcrumb with Custom Class ==="
puts breadcrumb.render
