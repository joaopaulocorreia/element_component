# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Card
# =============================================================================
card = ElementComponent::Components::Card.new
card.add_content("Simple card content")
puts "=== Basic Card ==="
puts card.render
puts

# =============================================================================
# Card with Header, Body, and Footer
# =============================================================================
card = ElementComponent::Components::Card.new do
  add_content(ElementComponent::Components::CardHeader.new { add_content("Header") })
  add_content(ElementComponent::Components::CardBody.new { add_content("Body content here") })
  add_content(ElementComponent::Components::CardFooter.new { add_content("Footer") })
end
puts "=== Card with Header, Body, Footer ==="
puts card.render
puts

# =============================================================================
# Card with Title and Text
# =============================================================================
card = ElementComponent::Components::Card.new do
  add_content(ElementComponent::Components::CardBody.new do
    add_content(ElementComponent::Components::CardTitle.new { add_content("Card Title") })
    add_content(ElementComponent::Components::CardText.new { add_content("Some quick example text.") })
  end)
end
puts "=== Card with Title and Text ==="
puts card.render
puts

# =============================================================================
# Card with Image
# =============================================================================
card = ElementComponent::Components::Card.new do
  add_content(ElementComponent::Components::CardImage.new(src: "image.jpg", top: true))
  add_content(ElementComponent::Components::CardBody.new do
    add_content(ElementComponent::Components::CardTitle.new { add_content("Image Card") })
    add_content(ElementComponent::Components::CardText.new { add_content("Card with an image on top.") })
  end)
end
puts "=== Card with Image ==="
puts card.render
puts

# =============================================================================
# Chained API
# =============================================================================
card = ElementComponent::Components::Card.new
card.add_content(
  ElementComponent::Components::CardBody.new
                                       .add_content("Chained content")
)
puts "=== Chained API ==="
puts card.render
