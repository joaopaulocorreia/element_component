# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Navbar
# =============================================================================
navbar = ElementComponent::Components::Navbar.new do
  add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { add_content("Navbar") })
  add_content(ElementComponent::Components::NavbarToggler.new(target: "basicNav"))
  add_content(ElementComponent::Components::NavbarCollapse.new(id: "basicNav") do
    add_content(ElementComponent::Components::NavbarNav.new do
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
      end)
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
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
navbar = ElementComponent::Components::Navbar.new(theme: :dark, background: :dark) do
  add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { add_content("Dark") })
  add_content(ElementComponent::Components::NavbarToggler.new(target: "darkNav"))
  add_content(ElementComponent::Components::NavbarCollapse.new(id: "darkNav") do
    add_content(ElementComponent::Components::NavbarNav.new do
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
      end)
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/contact") { add_content("Contact") })
      end)
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/disabled", disabled: true) do
          add_content("Disabled")
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
navbar = ElementComponent::Components::Navbar.new(container: "container") do
  add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { add_content("Container") })
  add_content(ElementComponent::Components::NavbarToggler.new(target: "containerNav"))
  add_content(ElementComponent::Components::NavbarCollapse.new(id: "containerNav") do
    add_content(ElementComponent::Components::NavbarNav.new do
      add_content(ElementComponent::Components::NavItem.new do
        add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
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
navbar = ElementComponent::Components::Navbar.new(container: false) do
  add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { add_content("Fluid") })
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
