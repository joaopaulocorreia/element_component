# frozen_string_literal: true

module ElementComponent
  E = Element

  def self.tag(name, content = nil, **attributes, &)
    Element.new(name, content, **attributes, &)
  end

  EC = Components

  Alert = Components::Alert
  Badge = Components::Badge
  Breadcrumb = Components::Breadcrumb
  Button = Components::Button
  ButtonGroup = Components::ButtonGroup
  Card = Components::Card
  Carousel = Components::Carousel
  CloseButton = Components::CloseButton
  Dropdown = Components::Dropdown
  ListGroup = Components::ListGroup
  Modal = Components::Modal
  Nav = Components::Nav
  Navbar = Components::Navbar
  Pagination = Components::Pagination
  Progress = Components::Progress
  Spinner = Components::Spinner
  Table = Components::Table

  AlertHeading = Components::AlertHeading
  AlertLink = Components::AlertLink
  AlertCloseButton = Components::AlertCloseButton
  BreadcrumbItem = Components::BreadcrumbItem
  CardHeader = Components::CardHeader
  CardBody = Components::CardBody
  CardFooter = Components::CardFooter
  CardTitle = Components::CardTitle
  CardText = Components::CardText
  CardImage = Components::CardImage
  CarouselItem = Components::CarouselItem
  CarouselCaption = Components::CarouselCaption
  DropdownMenu = Components::DropdownMenu
  DropdownItem = Components::DropdownItem
  DropdownDivider = Components::DropdownDivider
  DropdownHeader = Components::DropdownHeader
  ListGroupItem = Components::ListGroupItem
  ModalDialog = Components::ModalDialog
  ModalContent = Components::ModalContent
  ModalHeader = Components::ModalHeader
  ModalTitle = Components::ModalTitle
  ModalBody = Components::ModalBody
  ModalFooter = Components::ModalFooter
  NavItem = Components::NavItem
  NavLink = Components::NavLink
  NavbarBrand = Components::NavbarBrand
  NavbarToggler = Components::NavbarToggler
  NavbarCollapse = Components::NavbarCollapse
  NavbarNav = Components::NavbarNav
  PageItem = Components::PageItem
  ProgressBar = Components::ProgressBar

  # rubocop:disable Naming/MethodName
  module Shortcuts
    def Card(...) = ElementComponent::Card.new(...)
    def Alert(...) = ElementComponent::Alert.new(...)
    def Badge(...) = ElementComponent::Badge.new(...)
    def Button(...) = ElementComponent::Button.new(...)
    def ButtonGroup(...) = ElementComponent::ButtonGroup.new(...)
    def Breadcrumb(...) = ElementComponent::Breadcrumb.new(...)
    def Carousel(...) = ElementComponent::Carousel.new(...)
    def CloseButton(...) = ElementComponent::CloseButton.new(...)
    def Dropdown(...) = ElementComponent::Dropdown.new(...)
    def ListGroup(...) = ElementComponent::ListGroup.new(...)
    def Modal(...) = ElementComponent::Modal.new(...)
    def Nav(...) = ElementComponent::Nav.new(...)
    def Navbar(...) = ElementComponent::Navbar.new(...)
    def Pagination(...) = ElementComponent::Pagination.new(...)
    def Progress(...) = ElementComponent::Progress.new(...)
    def Spinner(...) = ElementComponent::Spinner.new(...)
    def Table(...) = ElementComponent::Table.new(...)
    def AlertHeading(...) = ElementComponent::AlertHeading.new(...)
    def AlertLink(...) = ElementComponent::AlertLink.new(...)
    def AlertCloseButton(...) = ElementComponent::AlertCloseButton.new(...)
    def BreadcrumbItem(...) = ElementComponent::BreadcrumbItem.new(...)
    def CardHeader(...) = ElementComponent::CardHeader.new(...)
    def CardBody(...) = ElementComponent::CardBody.new(...)
    def CardFooter(...) = ElementComponent::CardFooter.new(...)
    def CardTitle(...) = ElementComponent::CardTitle.new(...)
    def CardText(...) = ElementComponent::CardText.new(...)
    def CardImage(...) = ElementComponent::CardImage.new(...)
    def CarouselItem(...) = ElementComponent::CarouselItem.new(...)
    def CarouselCaption(...) = ElementComponent::CarouselCaption.new(...)
    def DropdownMenu(...) = ElementComponent::DropdownMenu.new(...)
    def DropdownItem(...) = ElementComponent::DropdownItem.new(...)
    def DropdownDivider(...) = ElementComponent::DropdownDivider.new(...)
    def DropdownHeader(...) = ElementComponent::DropdownHeader.new(...)
    def ListGroupItem(...) = ElementComponent::ListGroupItem.new(...)
    def ModalDialog(...) = ElementComponent::ModalDialog.new(...)
    def ModalContent(...) = ElementComponent::ModalContent.new(...)
    def ModalHeader(...) = ElementComponent::ModalHeader.new(...)
    def ModalTitle(...) = ElementComponent::ModalTitle.new(...)
    def ModalBody(...) = ElementComponent::ModalBody.new(...)
    def ModalFooter(...) = ElementComponent::ModalFooter.new(...)
    def NavItem(...) = ElementComponent::NavItem.new(...)
    def NavLink(...) = ElementComponent::NavLink.new(...)
    def NavbarBrand(...) = ElementComponent::NavbarBrand.new(...)
    def NavbarToggler(...) = ElementComponent::NavbarToggler.new(...)
    def NavbarCollapse(...) = ElementComponent::NavbarCollapse.new(...)
    def NavbarNav(...) = ElementComponent::NavbarNav.new(...)
    def PageItem(...) = ElementComponent::PageItem.new(...)
    def ProgressBar(...) = ElementComponent::ProgressBar.new(...)
    def E(...) = ElementComponent::E.new(...)
    def tag(...) = ElementComponent.tag(...)
  end
  # rubocop:enable Naming/MethodName
end

# Global aliases for convenience
EC = ElementComponent::Components
E = ElementComponent::Element
