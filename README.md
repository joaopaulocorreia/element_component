# ElementComponent

A lightweight and flexible HTML builder for Ruby. `ElementComponent` provides a simple, object-oriented way to construct HTML structures programmatically, with dynamic attribute management, content nesting, rendering hooks, and a comprehensive set of pre-built Bootstrap 5 components.

## Key Features

- **Object-Oriented HTML Construction** — Build HTML trees using Ruby objects with dynamic attribute management
- **Block DSL** — Nest content inline with block parameters and the `new_element` helper
- **Rendering Hooks** — `before_render`, `after_render`, and `around_render` callbacks for dynamic content
- **17 Bootstrap 5 Components** — Ready-to-use Alert, Badge, Breadcrumb, Button, ButtonGroup, Card, Carousel, CloseButton, Dropdown, ListGroup, Modal, Nav, Navbar, Pagination, Progress, Spinner, and Table
- **Chained API** — All `add_*` methods return `self` for method chaining
- **Self-Closing Tags** — Support for void elements like `<img>`, `<input>`, `<br>`

## Installation

Add to your application's Gemfile:

```bash
bundle add element_component
```

Or install directly:

```bash
gem install element_component
```

## Usage

### Creating Elements

```ruby
p = ElementComponent::Element.new("p", class: "text-bold")
p.add_content("Hello, World!")
puts p.render
# => <p class="text-bold">Hello, World!</p>
```

### Block DSL

Use a block to add content inline:

```ruby
div = ElementComponent::Element.new("div", class: "container") do |e|
  e.add_content("Welcome")
  e.add_content(ElementComponent::Element.new("h1") { |h| h.add_content("Title") })
end
puts div.render
# => <div class="container">Welcome<h1>Title</h1></div>
```

### The `new_element` Helper

Inside a block, use `new_element` as a shorthand:

```ruby
div = ElementComponent::Element.new("div") do |e|
  e.add_content(e.new_element("h1") { |h| h.add_content("Hello") })
  e.add_content(e.new_element("p", class: "lead") { |p| p.add_content("World") })
end
puts div.render
# => <div><h1>Hello</h1><p class="lead">World</p></div>
```

### Content Types

Content can be a string, an Element, or a block (Proc):

```ruby
div = ElementComponent::Element.new("div")

# String
div.add_content("plain text")

# Element instance
div.add_content(ElementComponent::Element.new("span") { |s| s.add_content("nested") })

# Block (evaluated at render time, has access to new_element)
div.add_content { |e| e.new_element("em") { |em| em.add_content("deferred") } }

puts div.render
# => <div>plain text<span>nested</span><em>deferred</em></div>
```

### Attribute Management

```ruby
btn = ElementComponent::Element.new("button", class: "btn", type: "button")

# Add more values to an attribute
btn.add_attribute(class: "btn-primary")

# Reset attributes and set new ones
btn.add_attribute!(id: "submit-btn", type: "submit")

# Remove an attribute
btn.remove_attribute(:type)

# Remove a specific value from an attribute
btn.remove_attribute_value(:class, "btn-primary")
```

### Self-Closing Tags

```ruby
img = ElementComponent::Element.new("img", closing_tag: false, src: "image.png", alt: "Logo")
puts img.render
# => <img src="image.png" alt="Logo">
```

### Rendering Hooks

`ElementComponent` supports `before_render`, `after_render`, and `around_render` hooks:

```ruby
div = ElementComponent::Element.new("div")
div.define_singleton_method(:before_render) { add_attribute(class: "dynamic") }
div.add_content("content")
puts div.render
# => <div class="dynamic">content</div>
```

## Pre-built Components (Bootstrap 5)

All components live under `ElementComponent::Components` and support the block DSL, chained `add_content`, and custom HTML attributes via `**attributes`.

### Quick Reference

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

### Alert


```ruby
alert = ElementComponent::Components::Alert.new(variant: :success) do |e|
  e.add_content("Operation completed!")
end
# => <div class="alert alert-success" role="alert">Operation completed!</div>
```

**Variants**: `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`

Dismissible alerts, headings, and links use sub-components:

```ruby
alert = ElementComponent::Components::Alert.new(variant: :warning, dismissible: true) do |e|
  e.add_content(ElementComponent::Components::AlertHeading.new { |h| h.add_content("Warning") })
  e.add_content("Please review. ")
  e.add_content(ElementComponent::Components::AlertLink.new(href: "/details") { |l| l.add_content("Details") })
end
# => <div class="alert alert-warning alert-dismissible" role="alert">
#      <h4 class="alert-heading">Warning</h4>
#      Please review.
#      <a class="alert-link" href="/details">Details</a>
#      <button class="btn-close" data-bs-dismiss="alert" aria-label="Close">
#    </div>
```

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `AlertHeading` | `<h4>` | `.alert-heading` |
| `AlertLink` | `<a>` | `.alert-link` |
| `AlertCloseButton` | `<button>` (self-closing) | `.btn-close` |

### Button


```ruby
# Standard button
btn = ElementComponent::Components::Button.new(variant: :primary) { |b| b.add_content("Click") }
# => <button class="btn btn-primary" type="button">Click</button>

# Outline variant
btn = ElementComponent::Components::Button.new(variant: :danger, outline: true) { |b| b.add_content("Delete") }
# => <button class="btn btn-outline-danger" type="button">Delete</button>

# As a link
btn = ElementComponent::Components::Button.new(variant: :primary, href: "/home") { |b| b.add_content("Home") }
# => <a class="btn btn-primary" href="/home">Home</a>
```

**Options**: `variant` (primary/secondary/success/danger/warning/info/light/dark/link), `outline`, `size` (sm/lg), `href`

### Badge


```ruby
badge = ElementComponent::Components::Badge.new(variant: :primary) { |b| b.add_content("New") }
# => <span class="badge bg-primary">New</span>

pill = ElementComponent::Components::Badge.new(variant: :danger, pill: true) { |b| b.add_content("99+") }
# => <span class="badge bg-danger rounded-pill">99+</span>
```

### Card


```ruby
card = ElementComponent::Components::Card.new do |c|
  c.add_content(ElementComponent::Components::CardImage.new(src: "photo.jpg", top: true))
  c.add_content(ElementComponent::Components::CardBody.new do |body|
    body.add_content(ElementComponent::Components::CardTitle.new { |t| t.add_content("Title") })
    body.add_content(ElementComponent::Components::CardText.new { |t| t.add_content("Some text.") })
  end)
  c.add_content(ElementComponent::Components::CardFooter.new { |f| f.add_content("Footer") })
end
```

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `CardHeader` | `<div>` | `.card-header` |
| `CardBody` | `<div>` | `.card-body` |
| `CardFooter` | `<div>` | `.card-footer` |
| `CardTitle` | `<h5>` | `.card-title` |
| `CardText` | `<p>` | `.card-text` |
| `CardImage` | `<img>` (self-closing) | `.card-img[-top\|-bottom]` |

### Nav


```ruby
nav = ElementComponent::Components::Nav.new(type: :tabs) do |n|
  n.add_content(ElementComponent::Components::NavItem.new do |item|
    item.add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { |l| l.add_content("Home") })
  end)
  n.add_content(ElementComponent::Components::NavItem.new do |item|
    item.add_content(ElementComponent::Components::NavLink.new(href: "/profile") { |l| l.add_content("Profile") })
  end)
end
# => <ul class="nav nav-tabs">...</ul>
```

**Options**: `type` (tabs/pills/underline), `fill`, `justified`, `vertical`

### Breadcrumb


```ruby
crumb = ElementComponent::Components::Breadcrumb.new do |b|
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { |i| i.add_content("Home") })
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/section") { |i| i.add_content("Section") })
  b.add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { |i| i.add_content("Current") })
end
# => <nav aria-label="breadcrumb"><ol class="breadcrumb">...</ol></nav>
```

### ListGroup


```ruby
list = ElementComponent::Components::ListGroup.new(flush: true) do |l|
  l.add_content(ElementComponent::Components::ListGroupItem.new { |i| i.add_content("Item 1") })
  l.add_content(ElementComponent::Components::ListGroupItem.new(active: true) { |i| i.add_content("Item 2") })
  l.add_content(ElementComponent::Components::ListGroupItem.new(href: "/link") { |i| i.add_content("Link") })
end
# => <ul class="list-group list-group-flush">...</ul>
```

**Options**: `flush`, `numbered`; `ListGroupItem` options: `variant`, `active`, `disabled`, `href`

### Progress


```ruby
progress = ElementComponent::Components::Progress.new do |p|
  p.add_content(ElementComponent::Components::ProgressBar.new(value: 75, variant: :success, striped: true) do |bar|
    bar.add_content("75%")
  end)
end
# => <div class="progress" role="progressbar"><div class="progress-bar bg-success progress-bar-striped" ...>75%</div></div>
```

### Spinner


```ruby
border = ElementComponent::Components::Spinner.new(type: :border, variant: :primary)
# => <div class="spinner-border text-primary" role="status"></div>

grow = ElementComponent::Components::Spinner.new(type: :grow, variant: :success)
# => <div class="spinner-grow text-success" role="status"></div>
```

### Table


```ruby
table = ElementComponent::Components::Table.new(striped: true, bordered: true, hover: true) do |t|
  t.add_content("<thead><tr><th>Name</th><th>Age</th></tr></thead>")
  t.add_content("<tbody><tr><td>John</td><td>30</td></tr></tbody>")
end
# => <table class="table table-striped table-bordered table-hover">...</table>
```

**Options**: `striped`, `bordered`, `hover`, `small`, `variant`

### Pagination


```ruby
nav = ElementComponent::Components::Pagination.new(size: :lg) do |p|
  p.add_content(ElementComponent::Components::PageItem.new(active: true) { |i| i.add_content("1") })
  p.add_content(ElementComponent::Components::PageItem.new { |i| i.add_content("2") })
end
# => <nav aria-label="Pagination"><ul class="pagination pagination-lg">...</ul></nav>
```

### ButtonGroup


```ruby
group = ElementComponent::Components::ButtonGroup.new do |g|
  g.add_content(ElementComponent::Components::Button.new(variant: :primary) { |b| b.add_content("Left") })
  g.add_content(ElementComponent::Components::Button.new(variant: :primary) { |b| b.add_content("Middle") })
  g.add_content(ElementComponent::Components::Button.new(variant: :primary) { |b| b.add_content("Right") })
end
# => <div class="btn-group" role="group">...</div>
```

**Options**: `size` (sm/lg), `vertical`

### CloseButton


```ruby
btn = ElementComponent::Components::CloseButton.new
# => <button class="btn-close" type="button" aria-label="Close">

disabled = ElementComponent::Components::CloseButton.new(disabled: true)
# => <button class="btn-close" type="button" aria-label="Close" disabled>
```

### Modal


```ruby
modal = ElementComponent::Components::Modal.new(id: "exampleModal") do |m|
  m.add_content(ElementComponent::Components::ModalContent.new do |content|
    content.add_content(ElementComponent::Components::ModalHeader.new do |header|
      header.add_content(ElementComponent::Components::ModalTitle.new { |t| t.add_content("Modal title") })
    end)
    content.add_content(ElementComponent::Components::ModalBody.new { |body| body.add_content("Modal body text.") })
    content.add_content(ElementComponent::Components::ModalFooter.new do |footer|
      footer.add_content(ElementComponent::Components::Button.new(variant: :secondary) { |b| b.add_content("Close") })
      footer.add_content(ElementComponent::Components::Button.new(variant: :primary) { |b| b.add_content("Save") })
    end)
  end)
end
```

**Options**: `fade`, `static`, `scrollable`, `centered`, `size` (sm/lg/xl), `fullscreen`

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `ModalDialog` | `<div>` | `.modal-dialog` |
| `ModalContent` | `<div>` | `.modal-content` |
| `ModalHeader` | `<div>` | `.modal-header` |
| `ModalTitle` | `<h5>` | `.modal-title` |
| `ModalBody` | `<div>` | `.modal-body` |
| `ModalFooter` | `<div>` | `.modal-footer` |

### Carousel


```ruby
carousel = ElementComponent::Components::Carousel.new(id: "slides") do |c|
  c.add_content(ElementComponent::Components::CarouselItem.new(active: true) do |item|
    item.add_content(%(<img src="slide1.jpg" class="d-block w-100" alt="...">))
  end)
  c.add_content(ElementComponent::Components::CarouselItem.new do |item|
    item.add_content(%(<img src="slide2.jpg" class="d-block w-100" alt="...">))
  end)
end
```

**Options**: `fade` (crossfade), `indicators`, `controls`; indicators and navigation controls are auto-generated

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `CarouselItem` | `<div>` | `.carousel-item` |
| `CarouselCaption` | `<div>` | `.carousel-caption` |

### Dropdown


```ruby
dropdown = ElementComponent::Components::Dropdown.new do |d|
  d.add_content(
    ElementComponent::Element.new("button",
      class: "btn btn-secondary dropdown-toggle",
      type: "button",
      "data-bs-toggle": "dropdown",
      "aria-expanded": "false") { |b| b.add_content("Dropdown") }
  )
  d.add_content(
    ElementComponent::Components::DropdownMenu.new do |menu|
      menu.add_content(ElementComponent::Components::DropdownItem.new { |i| i.add_content("Action") })
      menu.add_content(ElementComponent::Components::DropdownItem.new(active: true) { |i| i.add_content("Active") })
      menu.add_content(ElementComponent::Components::DropdownDivider.new)
      menu.add_content(ElementComponent::Components::DropdownItem.new(disabled: true) { |i| i.add_content("Disabled") })
    end
  )
end
```

**Options**: `direction` (dropup/dropend/dropstart)

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `DropdownMenu` | `<ul>` | `.dropdown-menu` |
| `DropdownItem` | `<li>` → `<a>`/`<button>` | `.dropdown-item` |
| `DropdownDivider` | `<li>` → `<hr>` | `.dropdown-divider` |
| `DropdownHeader` | `<li>` → `<h6>` | `.dropdown-header` |

### Navbar


```ruby
navbar = ElementComponent::Components::Navbar.new(theme: :dark, background: :dark) do |n|
  n.add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { |b| b.add_content("Brand") })
  n.add_content(ElementComponent::Components::NavbarToggler.new(target: "nav"))
  n.add_content(ElementComponent::Components::NavbarCollapse.new(id: "nav") do |collapse|
    collapse.add_content(ElementComponent::Components::NavbarNav.new do |nav|
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { |l| l.add_content("Home") })
      end)
      nav.add_content(ElementComponent::Components::NavItem.new do |item|
        item.add_content(ElementComponent::Components::NavLink.new(href: "/about") { |l| l.add_content("About") })
      end)
    end)
  end)
end
```

**Options**: `expand` (sm/md/lg/xl/xxl), `theme` (light/dark), `background`, `fixed` (top/bottom), `sticky` (top/bottom), `container`

**Sub-components**:

| Class | Tag | CSS Class |
|---|---|---|
| `NavbarBrand` | `<a>` | `.navbar-brand` |
| `NavbarToggler` | `<button>` (self-closing) | `.navbar-toggler` |
| `NavbarCollapse` | `<div>` | `.collapse .navbar-collapse` |
| `NavbarNav` | `<ul>` | `.navbar-nav` |

## Development

```bash
bin/setup              # Install dependencies
bundle exec rspec      # Run tests
bundle exec rubocop    # Lint
bundle exec rake       # Spec + RuboCop
bin/console            # Interactive console
ruby examples/alert_example.rb  # Run Alert examples
ruby examples/button_example.rb # Run Button examples
ruby examples/card_example.rb   # Run Card examples
# See all examples in the examples/ directory
```

### Test Coverage

Run with coverage reporting:

```bash
COVERAGE=true bundle exec rspec
```

### Release

```bash
# Update version in lib/element_component/version.rb
bundle exec rake release
```

Or push a version tag (e.g., `v0.6.0`) to trigger the automated release workflow.

## Roadmap

- [ ] Support for Caching
- [x] Pre-built Bootstrap components (Alert, Badge, Breadcrumb, Button, ButtonGroup, Card, Carousel, CloseButton, Dropdown, ListGroup, Modal, Nav, Navbar, Pagination, Progress, Spinner, Table)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joaopaulocorreia/element_component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
