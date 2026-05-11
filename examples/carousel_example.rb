# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Carousel
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "basicCarousel") do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) do |item|
    item.add_content(%(<img src="slide1.jpg" class="d-block w-100" alt="Slide 1">))
  end)
  c.add_content(ElementComponent::Components::CarouselItem.new do |item|
    item.add_content(%(<img src="slide2.jpg" class="d-block w-100" alt="Slide 2">))
  end)
end
puts "=== Basic Carousel ==="
puts carousel.render
puts

# =============================================================================
# Carousel with Captions
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "captionCarousel") do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) do |item|
    item.add_content(%(<img src="hero.jpg" class="d-block w-100" alt="Hero">))
    item.add_content(ElementComponent::Components::CarouselCaption.new do |cap|
      cap.add_content(%(<h5>First slide</h5><p>Some description here.</p>))
    end)
  end)
  c.add_content(ElementComponent::Components::CarouselItem.new do |item|
    item.add_content(%(<img src="hero2.jpg" class="d-block w-100" alt="Hero 2">))
    item.add_content(ElementComponent::Components::CarouselCaption.new do |cap|
      cap.add_content(%(<h5>Second slide</h5><p>Another description.</p>))
    end)
  end)
end
puts "=== Carousel with Captions ==="
puts carousel.render
puts

# =============================================================================
# Fade Carousel
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "fadeCarousel", fade: true) do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) { |item| item.add_content("Slide 1") })
  c.add_content(ElementComponent::Components::CarouselItem.new { |item| item.add_content("Slide 2") })
end
puts "=== Fade Carousel ==="
puts carousel.render
puts

# =============================================================================
# Carousel Without Indicators
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "noIndicators", indicators: false) do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) { |item| item.add_content("Slide 1") })
end
puts "=== Carousel Without Indicators ==="
puts carousel.render
puts

# =============================================================================
# Carousel Without Controls
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "noControls", controls: false) do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) { |item| item.add_content("Slide 1") })
end
puts "=== Carousel Without Controls ==="
puts carousel.render
puts

# =============================================================================
# Custom Interval
# =============================================================================
carousel = ElementComponent::Components::Carousel.new(id: "intervalCarousel") do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true, interval: 5000) do |item|
    item.add_content("Slide 1")
  end)
  c.add_content(ElementComponent::Components::CarouselItem.new(interval: 2000) { |item| item.add_content("Slide 2") })
end
puts "=== Carousel with Custom Interval ==="
puts carousel.render
puts

# =============================================================================
# Sub-Components Rendered Independently
# =============================================================================
puts "=== CarouselItem ==="
puts ElementComponent::Components::CarouselItem.new.render
puts

puts "=== CarouselItem Active ==="
puts ElementComponent::Components::CarouselItem.new(active: true).render
puts

puts "=== CarouselCaption ==="
puts ElementComponent::Components::CarouselCaption.new.render
