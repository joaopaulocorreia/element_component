# ElementComponent - Agent Instructions

## Project Overview
Ruby gem for building HTML programmatically with an object-oriented API. Provides dynamic attribute management, content nesting, and rendering hooks.

## Architecture

```
lib/
  element_component.rb              # Entry point, requires modules
  element_component/
    version.rb                      # VERSION constant
    element.rb                      # Core Element class
    components.rb                   # Component index, requires all components
    components/
      alert.rb                      # Alert component
      alert/
        heading.rb                  # AlertHeading component
        link.rb                     # AlertLink component
        close_button.rb             # AlertCloseButton component
      badge.rb                      # Badge component
      breadcrumb.rb                 # Breadcrumb component
      breadcrumb/
        item.rb                     # BreadcrumbItem component
      button.rb                     # Button component
      button_group.rb               # ButtonGroup component
      card.rb                       # Card component
      card/
        header.rb                   # CardHeader component
        body.rb                     # CardBody component
        footer.rb                   # CardFooter component
        title.rb                    # CardTitle component
        text.rb                     # CardText component
        image.rb                    # CardImage component
      carousel.rb                   # Carousel component
      carousel/
        item.rb                     # CarouselItem component
        caption.rb                  # CarouselCaption component
      close_button.rb               # CloseButton component
      dropdown.rb                   # Dropdown component
      dropdown/
        menu.rb                     # DropdownMenu component
        item.rb                     # DropdownItem component
        divider.rb                  # DropdownDivider component
        header.rb                   # DropdownHeader component
      list_group.rb                 # ListGroup component
      list_group/
        item.rb                     # ListGroupItem component
      modal.rb                      # Modal component
      modal/
        dialog.rb                   # ModalDialog component
        content.rb                  # ModalContent component
        header.rb                   # ModalHeader component
        title.rb                    # ModalTitle component
        body.rb                     # ModalBody component
        footer.rb                   # ModalFooter component
      nav.rb                        # Nav component
      nav/
        item.rb                     # NavItem component
        link.rb                     # NavLink component
      navbar.rb                     # Navbar component
      navbar/
        brand.rb                    # NavbarBrand component
        toggler.rb                  # NavbarToggler component
        collapse.rb                 # NavbarCollapse component
        nav.rb                      # NavbarNav component
      pagination.rb                 # Pagination component
      pagination/
        item.rb                     # PageItem component
      progress.rb                   # Progress component
      progress/
        bar.rb                      # ProgressBar component
      spinner.rb                    # Spinner component
      table.rb                      # Table component
spec/
  element_component_spec.rb         # Version check
  lib/
    element_spec.rb                 # Element unit tests
    components/
      alert_spec.rb                 # Alert component tests
      badge_spec.rb                 # Badge component tests
      breadcrumb_spec.rb            # Breadcrumb component tests
      button_spec.rb                # Button component tests
      button_group_spec.rb          # ButtonGroup component tests
      card_spec.rb                  # Card component tests
      carousel_spec.rb              # Carousel component tests
      close_button_spec.rb          # CloseButton component tests
      dropdown_spec.rb              # Dropdown component tests
      list_group_spec.rb            # ListGroup component tests
      modal_spec.rb                 # Modal component tests
      nav_spec.rb                   # Nav component tests
      navbar_spec.rb                # Navbar component tests
      pagination_spec.rb            # Pagination component tests
      progress_spec.rb              # Progress component tests
      spinner_spec.rb               # Spinner component tests
      table_spec.rb                 # Table component tests
  spec_helper.rb                    # RSpec config
examples/
  alert_example.rb                  # Complete Alert usage examples
```

## Core Classes

### `ElementComponent::Element`
- **Attributes**: `element` (tag name), `attributes` (Hash), `contents` (Array), `html` (rendered output)
- **Constructor**: `Element.new(tag_name, closing_tag: true, **attributes)`
- **Content methods**: `add_content`, `add_content!`, `add_content(&block)` — `content` can be a single value or an Array of values
- **Attribute methods**: `add_attribute`, `add_attribute!`, `remove_attribute`, `remove_attribute_value`
- **Render**: `render` (with hooks: `before_render`, `after_render`, `around_render`)

### Pre-built Components

Components live under `ElementComponent::Components`. Each component folder contains the main class and its sub-components in separate files.

| Component | Class | Tag | Key Options |
|---|---|---|---|
| Alert | `Alert` | `<div>` | `variant`, `dismissible` |
| Badge | `Badge` | `<span>` | `variant`, `pill` |
| Breadcrumb | `Breadcrumb` | `<nav>` → `<ol>` | `BreadcrumbItem` (`href`, `active`) |
| Button | `Button` | `<button>` / `<a>` | `variant`, `outline`, `size`, `href` |
| ButtonGroup | `ButtonGroup` | `<div>` | `size`, `vertical` |
| Card | `Card` | `<div>` | Sub-components: Header, Body, Footer, Title, Text, Image |
| Carousel | `Carousel` | `<div>` | `fade`, `indicators`, `controls`; `CarouselItem`, `CarouselCaption` |
| CloseButton | `CloseButton` | `<button>` (self-closing) | `disabled` |
| Dropdown | `Dropdown` | `<div>` | `direction`; `DropdownMenu`, `DropdownItem`, `DropdownDivider`, `DropdownHeader` |
| ListGroup | `ListGroup` | `<ul>` | `flush`, `numbered`; `ListGroupItem` (`variant`, `active`, `disabled`, `href`) |
| Modal | `Modal` | `<div>` | `fade`, `static`, `scrollable`, `centered`, `size`; `ModalContent`, `ModalHeader`, `ModalBody`, `ModalFooter` |
| Nav | `Nav` | `<ul>` | `type` (tabs/pills/underline), `fill`, `justified`, `vertical` |
| Navbar | `Navbar` | `<nav>` | `expand`, `theme`, `background`, `fixed`, `sticky`; `NavbarBrand`, `NavbarNav`, `NavbarToggler` |
| Pagination | `Pagination` | `<nav>` → `<ul>` | `size`; `PageItem` (`active`, `disabled`) |
| Progress | `Progress` | `<div>` | `ProgressBar` (`value`, `variant`, `striped`, `animated`) |
| Spinner | `Spinner` | `<div>` | `type` (border/grow), `variant` |
| Table | `Table` | `<table>` | `striped`, `bordered`, `hover`, `small`, `variant` |

**Alert constructor**: `Alert.new(variant: :primary, dismissible: false, **attributes, &block)`
- `variant`: one of `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`
- `dismissible`: adds `.alert-dismissible` class and appends a `CloseButton`
- `&block`: block with element parameter for adding content inside the element

**Component guidelines**:
- Always use `add_attribute()` instead of manipulating the `attributes` hash directly
- Each class in its own file under a component-named folder
- Call `super("tag_name", closing_tag: ..., &block)` first, then chain `add_attribute` calls
- `block.call(self)` lives in `Element#initialize` — passes element to block via block parameter
- Pass user attributes last via `add_attribute(attributes)`

### Sub-component example pattern:

```ruby
class AlertHeading < Element
  def initialize(**attributes, &block)
    super("h4", &block)
    add_attribute(class: "alert-heading")
    add_attribute(attributes)
  end
end
```

## Coding Conventions

- **Language**: Ruby 3.1+
- **Style**: Double quotes for strings
- **Testing**: RSpec with `expect` syntax, `subject` pattern
- **Linting**: RuboCop (run `bundle exec rubocop`)
- **Pattern matching**: Use `in` pattern matching (`case content; in Element; ...`)

## Common Commands

```bash
bin/setup              # Install dependencies
bundle exec rspec      # Run tests
bundle exec rubocop    # Lint
bundle exec rake spec  # Run tests via rake
bundle exec rake rubocop # Lint via rake
bundle exec rake       # Default: spec + rubocop
bin/console            # Interactive console
ruby examples/alert_example.rb  # Run Alert examples
```

## Testing Patterns

- Use `subject` for the element under test
- Use `before` blocks to set up state
- Test render output as raw HTML strings
- Test attribute hashes directly
- Follow existing describe/context/it structure

## Development Workflow

1. Write/update specs first
2. Implement in `lib/element_component/element.rb` or `lib/element_component/components/`
3. Run `bundle exec rspec` to verify
4. Run `bundle exec rubocop` for linting
5. Run `bundle exec rake` for full check

## Key Design Decisions

- Attributes stored as Hash of Symbol => Array of values (supports multiple values per attribute)
- Contents stored as Array (supports strings, Elements, Procs/blocks, and Arrays of any of these)
- `add_content(content)` accepts a single value or an Array; Arrays are spread into `@contents`
- `!` suffix methods reset state before adding (e.g., `add_content!` clears then adds)
- Hooks (`before_render`, `after_render`, `around_render`) are optional, detected via `respond_to?`
- Self-closing tags controlled by `closing_tag:` parameter
- Component classes use `add_attribute()` instead of direct hash manipulation

## Roadmap Features (from README)
- Caching support
