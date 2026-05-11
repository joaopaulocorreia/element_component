# ElementComponent

A lightweight and flexible HTML builder for Ruby. `ElementComponent` provides a simple, object-oriented way to construct HTML structures programmatically, with dynamic attribute management, content nesting, rendering hooks, and a comprehensive set of pre-built Bootstrap 5 components.

## Key Features

- **Object-Oriented HTML Construction** — Build HTML trees using Ruby objects with dynamic attribute management
- **Block DSL** — Nest content inline with `instance_eval`-based blocks and the `new_element` helper
- **Rendering Hooks** — `before_render`, `after_render`, and `around_render` callbacks for dynamic content
- **13 Bootstrap 5 Components** — Ready-to-use Alert, Badge, Breadcrumb, Button, ButtonGroup, Card, CloseButton, ListGroup, Nav, Pagination, Progress, Spinner, and Table
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
div = ElementComponent::Element.new("div", class: "container") do
  add_content("Welcome")
  add_content(ElementComponent::Element.new("h1") { add_content("Title") })
end
puts div.render
# => <div class="container">Welcome<h1>Title</h1></div>
```

### The `new_element` Helper

Inside a block, use `new_element` as a shorthand:

```ruby
div = ElementComponent::Element.new("div") do
  add_content(new_element("h1") { add_content("Hello") })
  add_content(new_element("p", class: "lead") { add_content("World") })
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
div.add_content(ElementComponent::Element.new("span") { add_content("nested") })

# Block (evaluated at render time, has access to new_element)
div.add_content { new_element("em") { add_content("deferred") } }

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
| CloseButton | `CloseButton` | `<button>` (self-closing) | `disabled` |
| ListGroup | `ListGroup` | `<ul>` | `flush`, `numbered`; `ListGroupItem` (`variant`, `active`, `disabled`, `href`) |
| Nav | `Nav` | `<ul>` | `type` (tabs/pills/underline), `fill`, `justified`, `vertical` |
| Pagination | `Pagination` | `<nav>` → `<ul>` | `size`; `PageItem` (`active`, `disabled`) |
| Progress | `Progress` | `<div>` | `ProgressBar` (`value`, `variant`, `striped`, `animated`) |
| Spinner | `Spinner` | `<div>` | `type` (border/grow), `variant` |
| Table | `Table` | `<table>` | `striped`, `bordered`, `hover`, `small`, `variant` |

### Alert

<img src="images/alert.png" alt="Alert component screenshot" width="700">

```ruby
alert = ElementComponent::Components::Alert.new(variant: :success) do
  add_content("Operation completed!")
end
# => <div class="alert alert-success" role="alert">Operation completed!</div>
```

**Variants**: `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`

Dismissible alerts, headings, and links use sub-components:

```ruby
alert = ElementComponent::Components::Alert.new(variant: :warning, dismissible: true) do
  add_content(ElementComponent::Components::AlertHeading.new { add_content("Warning") })
  add_content("Please review. ")
  add_content(ElementComponent::Components::AlertLink.new(href: "/details") { add_content("Details") })
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

<img src="images/button.png" alt="Button component screenshot" width="700">

```ruby
# Standard button
btn = ElementComponent::Components::Button.new(variant: :primary) { add_content("Click") }
# => <button class="btn btn-primary" type="button">Click</button>

# Outline variant
btn = ElementComponent::Components::Button.new(variant: :danger, outline: true) { add_content("Delete") }
# => <button class="btn btn-outline-danger" type="button">Delete</button>

# As a link
btn = ElementComponent::Components::Button.new(variant: :primary, href: "/home") { add_content("Home") }
# => <a class="btn btn-primary" href="/home">Home</a>
```

**Options**: `variant` (primary/secondary/success/danger/warning/info/light/dark/link), `outline`, `size` (sm/lg), `href`

### Badge

<img src="images/badge.png" alt="Badge component screenshot" width="700">

```ruby
badge = ElementComponent::Components::Badge.new(variant: :primary) { add_content("New") }
# => <span class="badge bg-primary">New</span>

pill = ElementComponent::Components::Badge.new(variant: :danger, pill: true) { add_content("99+") }
# => <span class="badge bg-danger rounded-pill">99+</span>
```

### Card

<img src="images/card.png" alt="Card component screenshot" width="700">

```ruby
card = ElementComponent::Components::Card.new do
  add_content(ElementComponent::Components::CardImage.new(src: "photo.jpg", top: true))
  add_content(ElementComponent::Components::CardBody.new do
    add_content(ElementComponent::Components::CardTitle.new { add_content("Title") })
    add_content(ElementComponent::Components::CardText.new { add_content("Some text.") })
  end)
  add_content(ElementComponent::Components::CardFooter.new { add_content("Footer") })
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

<img src="images/nav.png" alt="Nav component screenshot" width="700">

```ruby
nav = ElementComponent::Components::Nav.new(type: :tabs) do
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
  end)
  add_content(ElementComponent::Components::NavItem.new do
    add_content(ElementComponent::Components::NavLink.new(href: "/profile") { add_content("Profile") })
  end)
end
# => <ul class="nav nav-tabs">...</ul>
```

**Options**: `type` (tabs/pills/underline), `fill`, `justified`, `vertical`

### Breadcrumb

<img src="images/breadcrumb.png" alt="Breadcrumb component screenshot" width="700">

```ruby
crumb = ElementComponent::Components::Breadcrumb.new do
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/") { add_content("Home") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(href: "/section") { add_content("Section") })
  add_content(ElementComponent::Components::BreadcrumbItem.new(active: true) { add_content("Current") })
end
# => <nav aria-label="breadcrumb"><ol class="breadcrumb">...</ol></nav>
```

### ListGroup

<img src="images/list_group.png" alt="ListGroup component screenshot" width="700">

```ruby
list = ElementComponent::Components::ListGroup.new(flush: true) do
  add_content(ElementComponent::Components::ListGroupItem.new { add_content("Item 1") })
  add_content(ElementComponent::Components::ListGroupItem.new(active: true) { add_content("Item 2") })
  add_content(ElementComponent::Components::ListGroupItem.new(href: "/link") { add_content("Link") })
end
# => <ul class="list-group list-group-flush">...</ul>
```

**Options**: `flush`, `numbered`; `ListGroupItem` options: `variant`, `active`, `disabled`, `href`

### Progress

<img src="images/progress.png" alt="Progress component screenshot" width="700">

```ruby
progress = ElementComponent::Components::Progress.new do
  add_content(ElementComponent::Components::ProgressBar.new(value: 75, variant: :success, striped: true) do
    add_content("75%")
  end)
end
# => <div class="progress" role="progressbar"><div class="progress-bar bg-success progress-bar-striped" ...>75%</div></div>
```

### Spinner

<img src="images/spinner.png" alt="Spinner component screenshot" width="700">

```ruby
border = ElementComponent::Components::Spinner.new(type: :border, variant: :primary)
# => <div class="spinner-border text-primary" role="status"></div>

grow = ElementComponent::Components::Spinner.new(type: :grow, variant: :success)
# => <div class="spinner-grow text-success" role="status"></div>
```

### Table

<img src="images/table.png" alt="Table component screenshot" width="700">

```ruby
table = ElementComponent::Components::Table.new(striped: true, bordered: true, hover: true) do
  add_content("<thead><tr><th>Name</th><th>Age</th></tr></thead>")
  add_content("<tbody><tr><td>John</td><td>30</td></tr></tbody>")
end
# => <table class="table table-striped table-bordered table-hover">...</table>
```

**Options**: `striped`, `bordered`, `hover`, `small`, `variant`

### Pagination

<img src="images/pagination.png" alt="Pagination component screenshot" width="700">

```ruby
nav = ElementComponent::Components::Pagination.new(size: :lg) do
  add_content(ElementComponent::Components::PageItem.new(active: true) { add_content("1") })
  add_content(ElementComponent::Components::PageItem.new { add_content("2") })
end
# => <nav aria-label="Pagination"><ul class="pagination pagination-lg">...</ul></nav>
```

### ButtonGroup

<img src="images/button_group.png" alt="ButtonGroup component screenshot" width="700">

```ruby
group = ElementComponent::Components::ButtonGroup.new do
  add_content(ElementComponent::Components::Button.new(variant: :primary) { add_content("Left") })
  add_content(ElementComponent::Components::Button.new(variant: :primary) { add_content("Middle") })
  add_content(ElementComponent::Components::Button.new(variant: :primary) { add_content("Right") })
end
# => <div class="btn-group" role="group">...</div>
```

**Options**: `size` (sm/lg), `vertical`

### CloseButton

<img src="images/close_button.png" alt="CloseButton component screenshot" width="700">

```ruby
btn = ElementComponent::Components::CloseButton.new
# => <button class="btn-close" type="button" aria-label="Close">

disabled = ElementComponent::Components::CloseButton.new(disabled: true)
# => <button class="btn-close" type="button" aria-label="Close" disabled>
```

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
- [ ] Pre-built Bulma components
- [x] Pre-built Bootstrap components (Alert, Badge, Breadcrumb, Button, ButtonGroup, Card, CloseButton, ListGroup, Nav, Pagination, Progress, Spinner, Table)
- [ ] Enhanced DSL for nested structures

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joaopaulocorreia/element_component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
