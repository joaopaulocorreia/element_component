# frozen_string_literal: true

require_relative "../lib/element_component"

# =============================================================================
# Basic Modal
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "basicModal")
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalHeader.new do
      add_content(ElementComponent::Components::ModalTitle.new { add_content("Modal title") })
    end)
    add_content(ElementComponent::Components::ModalBody.new { add_content("Modal body text goes here.") })
    add_content(ElementComponent::Components::ModalFooter.new do
      add_content(ElementComponent::Components::Button.new(variant: :secondary) { add_content("Close") })
      add_content(ElementComponent::Components::Button.new(variant: :primary) { add_content("Save changes") })
    end)
  end
)
puts "=== Basic Modal ==="
puts modal.render
puts

# =============================================================================
# Scrollable Modal
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "scrollModal", scrollable: true)
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalHeader.new do
      add_content(ElementComponent::Components::ModalTitle.new { add_content("Scrollable") })
    end)
    add_content(ElementComponent::Components::ModalBody.new { add_content("Long content body...") })
    add_content(ElementComponent::Components::ModalFooter.new { add_content("Footer") })
  end
)
puts "=== Scrollable Modal ==="
puts modal.render
puts

# =============================================================================
# Centered Modal
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "centerModal", centered: true)
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalBody.new { add_content("Centered content") })
  end
)
puts "=== Centered Modal ==="
puts modal.render
puts

# =============================================================================
# Large Modal
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "lgModal", size: :lg)
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalBody.new { add_content("Large modal body") })
  end
)
puts "=== Large Modal ==="
puts modal.render
puts

# =============================================================================
# Static Backdrop Modal
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "staticModal", static: true)
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalBody.new { add_content("Click outside does not close") })
  end
)
puts "=== Static Backdrop Modal ==="
puts modal.render
puts

# =============================================================================
# Header Without Close
# =============================================================================
modal = ElementComponent::Components::Modal.new(id: "noCloseModal")
modal.add_content(
  ElementComponent::Components::ModalContent.new do
    add_content(ElementComponent::Components::ModalHeader.new(close_button: false) do
      add_content(ElementComponent::Components::ModalTitle.new { add_content("No close button") })
    end)
  end
)
puts "=== Modal Header Without Close ==="
puts modal.render
puts

# =============================================================================
# Sub-Components Rendered Independently
# =============================================================================
puts "=== ModalDialog ==="
puts ElementComponent::Components::ModalDialog.new.render
puts

puts "=== ModalContent ==="
puts ElementComponent::Components::ModalContent.new.render
puts

puts "=== ModalHeader ==="
puts ElementComponent::Components::ModalHeader.new.render
puts

puts "=== ModalTitle ==="
puts ElementComponent::Components::ModalTitle.new.render
puts

puts "=== ModalBody ==="
puts ElementComponent::Components::ModalBody.new.render
puts

puts "=== ModalFooter ==="
puts ElementComponent::Components::ModalFooter.new.render
