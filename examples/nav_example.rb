# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Nav
# =============================================================================
nav = ElementComponent::Components::Nav.new
puts "=== Basic Nav ==="
puts nav.render
puts

# =============================================================================
# Nav Tabs
# =============================================================================
nav = ElementComponent::Components::Nav.new(type: :tabs) do
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/profile") { add_content("Profile") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/messages", disabled: true) do
      add_content("Messages")
    end)
  end)
end
puts "=== Nav Tabs ==="
puts nav.render
puts

# =============================================================================
# Nav Pills
# =============================================================================
nav = ElementComponent::Components::Nav.new(type: :pills) do
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/") { add_content("Home") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
  end)
end
puts "=== Nav Pills ==="
puts nav.render
puts

# =============================================================================
# Nav Fill and Justified
# =============================================================================
nav = ElementComponent::Components::Nav.new(type: :pills, fill: true) do
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/") { add_content("Home") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
  end)
end
puts "=== Nav Fill ==="
puts nav.render
puts

# =============================================================================
# Vertical Nav
# =============================================================================
nav = ElementComponent::Components::Nav.new(vertical: true) do
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/") { add_content("Home") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
  end)
end
puts "=== Vertical Nav ==="
puts nav.render
