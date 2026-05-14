# ElementComponent - Agent Instructions

## Project Overview
Ruby gem for building HTML programmatically with an object-oriented API. Provides dynamic attribute management, content nesting, and rendering hooks.

## Architecture

```
lib/
  element_component.rb              # Entry point, requires modules
  element_component/
    version.rb                      # VERSION constant
    safe_string.rb                  # SafeString class (html_safe wrapper)
    debug.rb                        # Debugger class (trace/log/info)
    element.rb                      # Core Element class (escaping, caching, render)
    components.rb                   # Component index, requires all components
    aliases.rb                      # Namespace aliases and shortcuts
    rails.rb                        # RailsHelpers module (view_context integration)
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
  spec_helper.rb                    # RSpec config
  lib/
    element_spec.rb                 # Element unit tests
    debug_spec.rb                   # Debugger and debug integration tests
    aliases_spec.rb                 # Namespace aliases tests
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

## Namespace Aliases

All components and the Element class can be accessed in multiple ways to reduce verbosity:

### 1. Direct aliases (recommended)
```ruby
ElementComponent::Card.new("content")
ElementComponent::Alert.new("message", variant: :success)
ElementComponent::E.new("div", "content")
```

### 2. Short module alias
```ruby
EC::Card.new("content")
EC::E.new("span", "text")
```

### 3. Helper method for generic elements
```ruby
ElementComponent.tag("div", "content", class: "container")
ElementComponent.tag("div") { |e| e.add_content("block") }
```

### 4. View shortcuts (include in views/helpers)
```ruby
class MyView
  include ElementComponent::Shortcuts

  def render
    Card.new("content")
    E.new("span", "text")
    tag("div", "content")
  end
end
```

**All 48 components are available** via all four access patterns above.

## Core Classes

### `ElementComponent::Element` (alias: `ElementComponent::E`)
- **Attributes**: `element` (tag name), `attributes` (Hash), `contents` (Array), `html` (rendered output)
- **Constructor**: `Element.new(tag_name, content = nil, closing_tag: true, **attributes, &block)`
- **Content methods**: `add_content`, `add_content!`, `add_content(&block)` — `content` can be a single value or an Array of values
- **Attribute methods**: `add_attribute`, `add_attribute!`, `remove_attribute`, `remove_attribute_value`
- **Render**: `render` (with hooks: `before_render`, `after_render`, `around_render`)

### Pre-built Components

Components live under `ElementComponent::Components` (alias: `EC`). Direct aliases are also available under `ElementComponent::`.

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

**Alert constructor**: `Alert.new(content = nil, variant: :primary, dismissible: false, **attributes, &block)`
- `content`: optional content string or array, added before block content
- `variant`: one of `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`
- `dismissible`: adds `.alert-dismissible` class and appends a `CloseButton`
- `&block`: block with element parameter for adding content inside the element

**Component guidelines**:
- Always use `add_attribute()` instead of manipulating the `attributes` hash directly
- Each class in its own file under a component-named folder
- **Constructor pattern**: `def initialize(content = nil, **keyword_args, **attributes, &block)`
- Call `super("tag_name", &block)` first, then chain `add_attribute` calls, then `add_content(content) if content`
- Content from the `content` argument is added **before** block content
- Pass user attributes last via `add_attribute(attributes)`

### Component constructor pattern:

```ruby
class AlertHeading < Element
  def initialize(content = nil, **attributes)
    super("h4")
    add_attribute(class: "alert-heading")
    add_attribute(attributes) unless attributes.empty?
    add_content(content) if content
  end
end
```

### Components with internal content (e.g., Alert, ModalHeader):

```ruby
class Alert < Element
  def initialize(content = nil, variant: :primary, dismissible: false, **attributes, &block)
    super("div", &block)

    add_attribute(class: "alert")
    add_attribute(class: "alert-\#{variant}")
    add_attribute(class: "alert-dismissible") if dismissible
    add_attribute(role: "alert")

    add_attribute(attributes) unless attributes.empty?
    add_content(content) if content              # user content first
    add_content(AlertCloseButton.new) if dismissible  # internal content after
  end
end
```

### Components with conditional tag names (e.g., Button, ListGroupItem):

```ruby
class Button < Element
  def initialize(content = nil, variant: :primary, outline: false, size: nil, href: nil, **attributes, &block)
    if href
      super("a", &block)
      add_attribute(href: href)
    else
      super("button", &block)
      add_attribute(type: "button")
    end

    add_attribute(class: "btn")
    add_attribute(class: outline ? "btn-outline-\#{variant}" : "btn-\#{variant}")
    add_attribute(class: "btn-\#{size}") if size
    add_attribute(attributes) unless attributes.empty?
    add_content(content) if content
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
- Test new aliases in `spec/lib/aliases_spec.rb`

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
- `content` as first positional argument in all constructors (optional, default `nil`)
- Content argument is added before block content when both are provided
- All 48 components are aliased directly under `ElementComponent::` for convenience
- **HTML Escaping**: String content escaped via `CGI.escapeHTML` by default; `SafeString` (or `ElementComponent.html_safe`) marks content as safe to skip escaping
- **Attribute escaping**: Attribute values also escaped via `CGI.escapeHTML` in `mount_attributes`
- **No double-escape**: `Element#render` returns `SafeString`, so nested Elements are never re-escaped
- **Caching**: In-memory by default; uses `Rails.cache` when available. Enable via `element.cache`
- **Rails Helpers**: Optional `RailsHelpers` module with `method_missing` delegation to `view_context`
- **Debug System**: Per-instance (`element.debug_mode!`) or global (`ElementComponent.debug = true`). Logs events to stdout and stores trace in `element.debug_info[:debug_events]`. Categories: init, content, attribute, render, build, opening_tag, closing_tag, mount_attrs, mount_content, content_type, escape, wrap_content, cache, hook.
- `ElementComponent::E` is an alias for `ElementComponent::Element`
- `ElementComponent::EC` is an alias for `ElementComponent::Components`
- `ElementComponent.tag()` is a helper method for creating generic elements
- `ElementComponent::Shortcuts` module provides instance methods for use in views/helpers

## Roadmap Features (from README)
- Caching support
