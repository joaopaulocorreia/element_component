# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Alert
# =============================================================================
alert = ElementComponent::Components::Alert.new(context: :success)
alert.add_content("Operation completed successfully!")
puts "=== Basic Alert ==="
puts alert.render
puts

# =============================================================================
# All Contexts
# =============================================================================
puts "=== All Alert Contexts ==="
ElementComponent::Components::Alert::VALID_CONTEXTS.each do |context|
  alert = ElementComponent::Components::Alert.new(context: context)
  alert.add_content("#{context.capitalize} alert message here.")
  puts alert.render
end
puts

# =============================================================================
# Dismissible Alert (use block DSL so close button is always last)
# =============================================================================
alert = ElementComponent::Components::Alert.new(context: :warning, dismissible: true) do
  add_content("This alert can be dismissed.")
end
puts "=== Dismissible Alert ==="
puts alert.render
puts

# =============================================================================
# Alert with Custom Attributes
# =============================================================================
alert = ElementComponent::Components::Alert.new(
  context: :primary,
  id: "main-alert",
  style: "margin-top: 20px;"
)
alert.add_content("This alert has a custom ID and inline style.")
puts "=== Alert with Custom Attributes ==="
puts alert.render
puts

# =============================================================================
# Alert with Heading and Link (block DSL)
# =============================================================================
alert = ElementComponent::Components::Alert.new(context: :info) do
  add_content(ElementComponent::Components::AlertHeading.new.tap { |h| h.add_content("Information") })
  add_content("This is an important notice. ")
  add_content(ElementComponent::Components::AlertLink.new(href: "/details").tap { |l| l.add_content("View details") })
end
puts "=== Alert with Heading and Link ==="
puts alert.render
puts

# =============================================================================
# Dismissible Alert with Heading and Link
# =============================================================================
alert = ElementComponent::Components::Alert.new(context: :danger, dismissible: true) do
  add_content(ElementComponent::Components::AlertHeading.new.tap { |h| h.add_content("Error!") })
  add_content("Something went wrong. ")
  add_content(ElementComponent::Components::AlertLink.new(href: "/support").tap do |l|
    l.add_content("Contact support")
  end)
end
puts "=== Dismissible Alert with Heading and Link ==="
puts alert.render
puts

# =============================================================================
# Chained API Usage
# =============================================================================
alert = ElementComponent::Components::Alert.new(context: :secondary)
                                           .add_content("This alert was built using chained calls.")
puts "=== Chained API ==="
puts alert.render
puts

# =============================================================================
# Using Sub-Components Independently
# =============================================================================
heading = ElementComponent::Components::AlertHeading.new
heading.add_content("Standalone Heading")

link = ElementComponent::Components::AlertLink.new(href: "https://example.com")
link.add_content("Standalone Link")

close_btn = ElementComponent::Components::AlertCloseButton.new

puts "=== Sub-Components Rendered Independently ==="
puts heading.render
puts link.render
puts close_btn.render
