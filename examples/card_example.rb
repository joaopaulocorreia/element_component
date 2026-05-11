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
card = ElementComponent::Components::Card.new do |c|
  c.add_content(ElementComponent::Components::CardHeader.new { |ch| ch.add_content("Header") })
  c.add_content(ElementComponent::Components::CardBody.new { |cb| cb.add_content("Body content here") })
  c.add_content(ElementComponent::Components::CardFooter.new { |cf| cf.add_content("Footer") })
end
puts "=== Card with Header, Body, Footer ==="
puts card.render
puts

# =============================================================================
# Card with Title and Text
# =============================================================================
card = ElementComponent::Components::Card.new do |c|
  c.add_content(ElementComponent::Components::CardBody.new do |cb|
    cb.add_content(ElementComponent::Components::CardTitle.new { |ct| ct.add_content("Card Title") })
    cb.add_content(ElementComponent::Components::CardText.new { |ct| ct.add_content("Some quick example text.") })
  end)
end
puts "=== Card with Title and Text ==="
puts card.render
puts

# =============================================================================
# Card with Image
# =============================================================================
card = ElementComponent::Components::Card.new do |c|
  c.add_content(ElementComponent::Components::CardImage.new(src: "image.jpg", top: true))
  c.add_content(ElementComponent::Components::CardBody.new do |cb|
    cb.add_content(ElementComponent::Components::CardTitle.new { |ct| ct.add_content("Image Card") })
    cb.add_content(ElementComponent::Components::CardText.new { |ct| ct.add_content("Card with an image on top.") })
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
