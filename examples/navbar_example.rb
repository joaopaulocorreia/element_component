# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Navbar
# =============================================================================
navbar = ElementComponent::Components::Navbar.new do |n|
  n.add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { |brand| brand.add_content("Navbar") })
  n.add_content(ElementComponent::Components::NavbarToggler.new(target: "basicNav"))
  n.add_content(ElementComponent::Components::NavbarCollapse.new(id: "basicNav") do |collapse|
    collapse.add_content(ElementComponent::Components::NavbarNav.new do |nav|
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) do |link|
          link.add_content("Home")
        end)
      end)
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/about") { |link| link.add_content("About") })
      end)
    end)
  end)
end
puts "=== Basic Navbar ==="
puts navbar.render
puts

# =============================================================================
# Dark Navbar
# =============================================================================
navbar = ElementComponent::Components::Navbar.new(theme: :dark, background: :dark) do |n|
  n.add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { |brand| brand.add_content("Dark") })
  n.add_content(ElementComponent::Components::NavbarToggler.new(target: "darkNav"))
  n.add_content(ElementComponent::Components::NavbarCollapse.new(id: "darkNav") do |collapse|
    collapse.add_content(ElementComponent::Components::NavbarNav.new do |nav|
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) do |link|
          link.add_content("Home")
        end)
      end)
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/contact") do |link|
          link.add_content("Contact")
        end)
      end)
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/disabled", disabled: true) do |link|
          link.add_content("Disabled")
        end)
      end)
    end)
  end)
end
puts "=== Dark Navbar ==="
puts navbar.render
puts

# =============================================================================
# Navbar with Container
# =============================================================================
navbar = ElementComponent::Components::Navbar.new(container: "container") do |n|
  n.add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { |brand| brand.add_content("Container") })
  n.add_content(ElementComponent::Components::NavbarToggler.new(target: "containerNav"))
  n.add_content(ElementComponent::Components::NavbarCollapse.new(id: "containerNav") do |collapse|
    collapse.add_content(ElementComponent::Components::NavbarNav.new do |nav|
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) do |link|
          link.add_content("Home")
        end)
      end)
    end)
  end)
end
puts "=== Navbar with Container ==="
puts navbar.render
puts

# =============================================================================
# Navbar Without Container
# =============================================================================
navbar = ElementComponent::Components::Navbar.new(container: false) do |n|
  n.add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { |brand| brand.add_content("Fluid") })
end
puts "=== Navbar Without Container ==="
puts navbar.render
puts

# =============================================================================
# Sub-Components Rendered Independently
# =============================================================================
puts "=== NavbarBrand ==="
puts ElementComponent::Components::NavbarBrand.new(href: "/").render
puts

puts "=== NavbarToggler ==="
puts ElementComponent::Components::NavbarToggler.new(target: "myNav").render
puts

puts "=== NavbarCollapse ==="
puts ElementComponent::Components::NavbarCollapse.new(id: "myNav").render
puts

puts "=== NavbarNav ==="
puts ElementComponent::Components::NavbarNav.new.render
