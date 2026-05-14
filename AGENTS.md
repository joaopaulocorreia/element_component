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

## Component Specifications

### Namespace Aliases

All components and the Element class can be accessed in multiple ways to reduce verbosity:

#### 1. Direct aliases (recommended)
```ruby
ElementComponent::Card.new("content")
ElementComponent::Alert.new("message", variant: :success)
ElementComponent::E.new("div", "content")
```

#### 2. Short module alias
```ruby
EC::Card.new("content")
EC::E.new("span", "text")
```

#### 3. Helper method for generic elements
```ruby
ElementComponent.tag("div", "content", class: "container")
ElementComponent.tag("div") { |e| e.add_content("block") }
```

#### 4. View shortcuts (include in views/helpers)
```ruby
class MyView
  include ElementComponent::Shortcuts

  def render
    Card.new("content")
    E.new("span", "text")
    element_tag("div", "content")
  end
end
```

**All 48 components are available** via all four access patterns above.

---

### Element — Generic HTML Element

| Property | Value |
|---|---|
| Class | `ElementComponent::Element` alias `E` |
| Tag | Dynamic (first argument) |
| Closing tag | `closing_tag: true` (pass `false` for void elements like `<br>`, `<img>`) |

#### Public API
```ruby
Element.new(tag_name, content = nil, closing_tag: true, **attributes, &block)
```

| Parameter | Type | Default | Description |
|---|---|---|---|
| `tag_name` | String/Symbol | required | HTML tag name |
| `content` | String, Element, Array | `nil` | Initial content, added before block content |
| `closing_tag` | Boolean | `true` | Set `false` for void elements |
| `**attributes` | Hash | `{}` | HTML attributes (class, id, href, etc.) |
| `&block` | Proc | `nil` | Block receives `self` (the Element). Content added via `e << ...` |

#### Methods
| Method | Returns | Description |
|---|---|---|
| `add_content(content)` | `self` | Pushes content (String, Element, Array). Array is splatted. |
| `add_content!(content)` | `self` | Resets contents, then adds |
| `add_content(&block)` | `self` | Executes block immediately with `self` as argument |
| `<<(content)` | `self` | Alias for `add_content` |
| `add_attribute(hash)` | `self` | Adds/replaces attribute values |
| `add_attribute!(hash)` | `self` | Resets attributes, then adds |
| `remove_attribute(key)` | `self` | Removes attribute entirely |
| `remove_attribute_value(key, value)` | `self` | Removes a single value from an attribute |
| `render` | SafeString | Renders HTML string |
| `render_in(*)` | SafeString | Alias for render (Rails compatibility) |
| `html_safe` | `self` | Marks element as safe (skips escaping when nested) |
| `html_safe?` | Boolean | Whether element is marked safe |
| `cache(key: nil, expires_in: nil)` | `self` | Enables caching |
| `expire_cache!` | `self` | Clears cache |
| `new_element(...)` | Element | Creates child Element (same as `Element.new`) |

#### HTML Output Structure
```
<tag_name attr="value">contents</tag_name>
```

#### Attributes Handling
- Attributes stored as `Hash[Symbol => Array[String]]` (supports multiple values per key)
- CSS classes are auto-split on whitespace when added
- `add_attribute(class: "foo bar")` pushes both `"foo"` and `"bar"` to the class array
- Rendering joins values with space: `class="foo bar"`

#### Content Handling (Eager Execution)
- Blocks execute **immediately** in `add_content`/constructor, NOT at render time
- `@contents` always contains resolved content (Strings, Elements, SafeStrings)
- Procs are never stored in `@contents`
- `render` is a pure operation that just joins rendered HTML

---

### Alert

| Property | Value |
|---|---|
| Class | `Alert` (under `Components`, direct alias under `ElementComponent`) |
| Tag | `<div>` |
| Role | `role="alert"` |

#### Public API
```ruby
Alert.new(content = nil, variant: :primary, dismissible: false, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `variant` | Symbol | `:primary` | `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark` |
| `dismissible` | Boolean | `false` | When true, adds `.alert-dismissible` class and appends `AlertCloseButton` |

#### HTML Output
```html
<div class="alert alert-primary" role="alert">
  content here
</div>
```

With `dismissible: true`:
```html
<div class="alert alert-primary alert-dismissible" role="alert">
  content here
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `AlertHeading` | `<h4>` | `alert-heading` | `AlertHeading.new(content = nil, **attributes)` |
| `AlertLink` | `<a>` | `alert-link` | `AlertLink.new(content = nil, href: "#", **attributes)` |
| `AlertCloseButton` | `<button>` (self-closing) | `btn-close` | `AlertCloseButton.new(**attributes)` |

#### Composition
```
Alert
├── content (optional, before block)
├── block content
└── AlertCloseButton (if dismissible, after all content)
```

#### Usage Examples
```ruby
# Simple alert
Alert.new("Operation completed!")

# With variant
Alert.new("Something went wrong", variant: :danger)

# Dismissible alert
Alert.new("Dismiss me", variant: :info, dismissible: true)

# With block for complex content
Alert.new(variant: :success) do |e|
  e << AlertHeading.new("Success!")
  e << "Your changes have been saved."
  e << AlertLink.new("Undo", href: "/undo")
end
```

---

### Badge

| Property | Value |
|---|---|
| Class | `Badge` |
| Tag | `<span>` |

#### Public API
```ruby
Badge.new(content = nil, variant: :primary, pill: false, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `variant` | Symbol | `:primary` | `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark` |
| `pill` | Boolean | `false` | When true, adds `.rounded-pill` class |

#### HTML Output
```html
<span class="badge bg-primary">content</span>
```

With `pill: true`:
```html
<span class="badge bg-primary rounded-pill">content</span>
```

#### Sub-components
None (leaf component).

#### Composition
```
Badge (no sub-components, content only)
```

#### Usage Examples
```ruby
Badge.new("New")
Badge.new("99+", variant: :danger, pill: true)
Badge.new(variant: :success) { |e| e << "Active" }
```

---

### Breadcrumb

| Property | Value |
|---|---|
| Class | `Breadcrumb` |
| Tag | `<nav>` |
| Inner wrapper | `<ol class="breadcrumb">` |

#### Public API
```ruby
Breadcrumb.new(content = nil, **attributes, &)
```

Note: Uses anonymous block parameter `&`.

#### HTML Output
```html
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Current</li>
  </ol>
</nav>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `BreadcrumbItem` | `<li>` | `breadcrumb-item` | `BreadcrumbItem.new(content, href: nil, active: false, **attributes, &block)` |

**BreadcrumbItem details:**
- If `href` is provided AND content contains no Elements, wraps content in `<a href="...">`
- If `href` is nil, renders `<li>` with just the text (no link wrapping)
- Uses `wrap_content` method to conditionally wrap in `<a>`

#### Composition
```
Breadcrumb (<nav>)
└── <ol class="breadcrumb">
    └── BreadcrumbItem (<li>) × N
```

#### Usage Examples
```ruby
Breadcrumb.new do |e|
  e << BreadcrumbItem.new("Home", href: "/")
  e << BreadcrumbItem.new("Products", href: "/products")
  e << BreadcrumbItem.new("Current", active: true)
end
```

---

### Button

| Property | Value |
|---|---|
| Class | `Button` |
| Tag | `<button>` or `<a>` (conditional on `href`) |

#### Public API
```ruby
Button.new(content = nil, variant: :primary, outline: false, size: nil, href: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `variant` | Symbol | `:primary` | `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`, `:link` |
| `outline` | Boolean | `false` | Uses `btn-outline-{variant}` instead of `btn-{variant}` |
| `size` | Symbol | `nil` | `:sm`, `:lg` |
| `href` | String | `nil` | When set, renders `<a>` instead of `<button>` |

#### HTML Output
```html
<button type="button" class="btn btn-primary">content</button>
```

With `outline: true`:
```html
<button type="button" class="btn btn-outline-primary">content</button>
```

With `href: "/link"`:
```html
<a href="/link" class="btn btn-primary">content</a>
```

#### Sub-components
None (leaf component).

#### Composition
```
Button (no sub-components, content only)
```

#### Usage Examples
```ruby
Button.new("Click me")
Button.new("Delete", variant: :danger, size: :sm)
Button.new("Outline", variant: :success, outline: true)
Button.new("Link", variant: :link, href: "/page")
```

---

### ButtonGroup

| Property | Value |
|---|---|
| Class | `ButtonGroup` |
| Tag | `<div>` |
| Role | `role="group"` |

#### Public API
```ruby
ButtonGroup.new(content = nil, size: nil, vertical: false, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `size` | Symbol | `nil` | `:sm`, `:lg` |
| `vertical` | Boolean | `false` | Uses `btn-group-vertical` instead of `btn-group` |

#### HTML Output
```html
<div class="btn-group" role="group">buttons here</div>
```

With `vertical: true`:
```html
<div class="btn-group-vertical" role="group">buttons here</div>
```

#### Sub-components
Container for `Button` components.

#### Composition
```
ButtonGroup
├── Button × N
```

#### Usage Examples
```ruby
ButtonGroup.new do |e|
  e << Button.new("Left", variant: :info)
  e << Button.new("Middle", variant: :info)
  e << Button.new("Right", variant: :info)
end

ButtonGroup.new(vertical: true, size: :sm) do |e|
  e << Button.new("Top")
  e << Button.new("Bottom")
end
```

---

### Card

| Property | Value |
|---|---|
| Class | `Card` |
| Tag | `<div>` |

#### Public API
```ruby
Card.new(content = nil, **attributes, &)
```

#### HTML Output
```html
<div class="card">
  <div class="card-header">Header</div>
  <div class="card-body">
    <h5 class="card-title">Title</h5>
    <p class="card-text">Text</p>
  </div>
  <div class="card-footer">Footer</div>
</div>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `CardHeader` | `<div>` | `card-header` | `CardHeader.new(content = nil, **attributes, &)` |
| `CardBody` | `<div>` | `card-body` | `CardBody.new(content = nil, **attributes, &)` |
| `CardFooter` | `<div>` | `card-footer` | `CardFooter.new(content = nil, **attributes, &)` |
| `CardTitle` | `<h5>` | `card-title` | `CardTitle.new(content = nil, **attributes, &)` |
| `CardText` | `<p>` | `card-text` | `CardText.new(content = nil, **attributes, &)` |
| `CardImage` | `<img>` (self-closing) | `card-img`, `card-img-top`, `card-img-bottom` | `CardImage.new(src: "", top: false, bottom: false, **attributes)` |

#### Composition
```
Card
├── CardImage (optional, top/bottom)
├── CardHeader (optional)
├── CardBody
│   ├── CardTitle
│   ├── CardText
│   └── (any other content)
├── CardFooter (optional)
└── CardImage (optional, bottom)
```

#### Usage Examples
```ruby
# Simple card
Card.new do |e|
  e << CardHeader.new("Header")
  e << CardBody.new("Body content")
  e << CardFooter.new("Footer")
end

# Card with image, title, and text
Card.new do |e|
  e << CardImage.new(src: "/image.jpg", top: true)
  e << CardBody.new do |body|
    body << CardTitle.new("Card Title")
    body << CardText.new("Some quick example text.")
    body << Button.new("Go somewhere", variant: :primary)
  end
end
```

---

### Carousel

| Property | Value |
|---|---|
| Class | `Carousel` |
| Tag | `<div>` |

#### Public API
```ruby
Carousel.new(content = nil, id: "carousel", fade: false, indicators: true, controls: true, **attributes, &block)
```

| Parameter | Type | Default | Description |
|---|---|---|---|
| `id` | String | `"carousel"` | HTML id, used for indicator/control targets |
| `fade` | Boolean | `false` | Adds `.carousel-fade` class |
| `indicators` | Boolean | `true` | Renders indicator buttons |
| `controls` | Boolean | `true` | Renders prev/next control buttons |

#### HTML Output
```html
<div id="carousel" class="carousel slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
    <button type="button" data-bs-target="#carousel" data-bs-slide-to="1"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">item 1</div>
    <div class="carousel-item">item 2</div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">...</button>
  <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">...</button>
</div>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `CarouselItem` | `<div>` | `carousel-item` | `CarouselItem.new(content = nil, active: false, interval: nil, **attributes, &block)` |
| `CarouselCaption` | `<div>` | `carousel-caption` | `CarouselCaption.new(content = nil, **attributes, &)` |

#### Composition
```
Carousel
├── indicators (auto-generated from CarouselItem count)
├── CarouselItem × N
│   └── CarouselCaption (optional inside item)
└── controls (prev/next buttons)
```

#### Usage Examples
```ruby
Carousel.new(id: "myCarousel") do |e|
  e << CarouselItem.new(active: true) do |item|
    item << "<img src='slide1.jpg' class='d-block w-100'>".html_safe
    item << CarouselCaption.new("First slide")
  end
  e << CarouselItem.new do |item|
    item << "<img src='slide2.jpg' class='d-block w-100'>".html_safe
  end
end

# With fade effect, no indicators
Carousel.new(fade: true, indicators: false) do |e|
  e << CarouselItem.new("content 1", active: true)
  e << CarouselItem.new("content 2")
end
```

---

### CloseButton

| Property | Value |
|---|---|
| Class | `CloseButton` |
| Tag | `<button>` (self-closing) |

#### Public API
```ruby
CloseButton.new(disabled: false, **attributes)
```

| Parameter | Type | Default | Description |
|---|---|---|---|
| `disabled` | Boolean | `false` | Adds `disabled=""` attribute |

#### HTML Output
```html
<button type="button" class="btn-close" aria-label="Close">
```

With `disabled: true`:
```html
<button type="button" class="btn-close" aria-label="Close" disabled="">
```

#### Sub-components
None.

#### Composition
Leaf component (self-closing, no children).

#### Usage Examples
```ruby
CloseButton.new
CloseButton.new(disabled: true)
CloseButton.new(class: "custom-close")
```

---

### Dropdown

| Property | Value |
|---|---|
| Class | `Dropdown` |
| Tag | `<div>` |

#### Public API
```ruby
Dropdown.new(content = nil, direction: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `direction` | Symbol | `nil` | `:dropup`, `:dropend`, `:dropstart` |

#### HTML Output
```html
<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Dropdown button
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Action</a></li>
    <li><hr class="dropdown-divider"></li>
    <li><h6 class="dropdown-header">Header</h6></li>
  </ul>
</div>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `DropdownMenu` | `<ul>` | `dropdown-menu` | `DropdownMenu.new(content = nil, align: nil, **attributes, &block)` |
| `DropdownItem` | `<li>` wrapper, inner `<a>` or `<button>` | `dropdown-item` | `DropdownItem.new(content = nil, type: :link, href: "#", active: false, disabled: false, **attributes, &block)` |
| `DropdownDivider` | `<li>` wrapper, inner `<hr>` | `dropdown-divider` | `DropdownDivider.new(**attributes)` |
| `DropdownHeader` | `<li>` wrapper, inner `<h6>` | `dropdown-header` | `DropdownHeader.new(content = nil, **attributes, &)` |

#### Special Method
`toggle_button(label: "Dropdown", variant: :secondary, split: false, **btn_attributes, &block)`:
- Convenience method that creates a toggle button inside the dropdown
- `split: true` generates a split-button pattern using `ButtonGroup`

**Important:** DropdownItem, DropdownDivider, and DropdownHeader use `mount_content` to wrap inner elements in `<li>`. Their `render` output includes the `<li>` wrapper.

#### Composition
```
Dropdown
├── toggle button (optional, via toggle_button method)
├── DropdownMenu
│   ├── DropdownItem × N
│   ├── DropdownDivider
│   ├── DropdownHeader
│   └── DropdownItem × N
```

#### Usage Examples
```ruby
Dropdown.new do |e|
  e.toggle_button(label: "Actions", variant: :primary)
  e << DropdownMenu.new do |menu|
    menu << DropdownItem.new("Action", href: "/action")
    menu << DropdownItem.new("Another action", href: "/another")
    menu << DropdownDivider.new
    menu << DropdownHeader.new("More options")
    menu << DropdownItem.new("Separated link", href: "/separated")
  end
end
```

---

### ListGroup

| Property | Value |
|---|---|
| Class | `ListGroup` |
| Tag | `<ul>` |

#### Public API
```ruby
ListGroup.new(content = nil, flush: false, numbered: false, **attributes, &block)
```

| Parameter | Type | Default | Description |
|---|---|---|---|
| `flush` | Boolean | `false` | Adds `.list-group-flush` class |
| `numbered` | Boolean | `false` | Adds `.list-group-numbered` class |

#### HTML Output
```html
<ul class="list-group">
  <li class="list-group-item">Default item</li>
  <li class="list-group-item active" aria-current="true">Active item</li>
  <a href="/link" class="list-group-item list-group-item-action">Link item</a>
</ul>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `ListGroupItem` | `<li>` or `<a>` (conditional on `href`) | `list-group-item` | `ListGroupItem.new(content, variant: nil, active: false, disabled: false, href: nil, **attributes, &block)` |

**ListGroupItem details:**
- If `href` is provided, renders `<a>` tag instead of `<li>`
- When `href` is set, adds `.list-group-item-action` class
- `variant`: `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`

#### Composition
```
ListGroup
├── ListGroupItem × N
```

#### Usage Examples
```ruby
ListGroup.new do |e|
  e << ListGroupItem.new("Inbox")
  e << ListGroupItem.new("Drafts", active: true)
  e << ListGroupItem.new("Trash", disabled: true)
end

# Flush + numbered
ListGroup.new(flush: true, numbered: true) do |e|
  e << ListGroupItem.new("Item 1")
  e << ListGroupItem.new("Item 2")
end

# Items as links
ListGroup.new do |e|
  e << ListGroupItem.new("Profile", href: "/profile")
  e << ListGroupItem.new("Settings", href: "/settings", active: true)
end
```

---

### Modal

| Property | Value |
|---|---|
| Class | `Modal` |
| Tag | `<div>` |

#### Public API
```ruby
Modal.new(fade: true, static: false, scrollable: false, centered: false, size: nil, fullscreen: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `fade` | Boolean | `true` | Adds `.fade` class |
| `static` | Boolean | `false` | Prevents closing on backdrop click |
| `scrollable` | Boolean | `false` | Adds `.modal-dialog-scrollable` |
| `centered` | Boolean | `false` | Adds `.modal-dialog-centered` |
| `size` | Symbol | `nil` | `:sm`, `:lg`, `:xl` |
| `fullscreen` | Symbol | `nil` | `:always`, `:sm`, `:md`, `:lg`, `:xl`, `:xxl` |

#### HTML Output
```html
<div class="modal fade" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <div class="modal-body">Body content</div>
      <div class="modal-footer">Footer content</div>
    </div>
  </div>
</div>
```

**Important:** Modal auto-creates a `ModalDialog` as its content. You don't need to add one manually — just add `ModalContent`, `ModalHeader`, etc. to the dialog.

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `ModalDialog` | `<div>` | `modal-dialog` | `ModalDialog.new(content, scrollable:, centered:, size:, fullscreen:, **attributes, &block)` |
| `ModalContent` | `<div>` | `modal-content` | `ModalContent.new(content = nil, **attributes, &)` |
| `ModalHeader` | `<div>` | `modal-header` | `ModalHeader.new(content = nil, close_button: true, **attributes, &block)` |
| `ModalTitle` | `<h5>` | `modal-title` | `ModalTitle.new(content = nil, **attributes, &)` |
| `ModalBody` | `<div>` | `modal-body` | `ModalBody.new(content = nil, **attributes, &)` |
| `ModalFooter` | `<div>` | `modal-footer` | `ModalFooter.new(content = nil, **attributes, &)` |

#### Auto-generated Structure
The `Modal` constructor **always creates** a `ModalDialog` as its first (and only direct) content. You add content inside the dialog via the block.

#### Composition
```
Modal
└── ModalDialog (auto-created)
    └── ModalContent
        ├── ModalHeader
        │   ├── ModalTitle
        │   └── CloseButton (if close_button: true)
        ├── ModalBody
        └── ModalFooter
```

#### Usage Examples
```ruby
Modal.new do |e|
  e << ModalContent.new do |content|
    content << ModalHeader.new do |header|
      header << ModalTitle.new("Modal Title")
    end
    content << ModalBody.new("Modal body text goes here.")
    content << ModalFooter.new do |footer|
      footer << Button.new("Close", variant: :secondary)
      footer << Button.new("Save", variant: :primary)
    end
  end
end

# Large centered modal, static backdrop
Modal.new(size: :lg, centered: true, static: true) do |e|
  e << ModalContent.new do |content|
    content << ModalHeader.new("Large Modal")
    content << ModalBody.new("Content")
  end
end
```

---

### Nav

| Property | Value |
|---|---|
| Class | `Nav` |
| Tag | `<ul>` |

#### Public API
```ruby
Nav.new(content = nil, type: nil, fill: false, justified: false, vertical: false, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `type` | Symbol | `nil` | `:tabs`, `:pills`, `:underline` |
| `fill` | Boolean | `false` | Adds `.nav-fill` class |
| `justified` | Boolean | `false` | Adds `.nav-justified` class |
| `vertical` | Boolean | `false` | Adds `.flex-column` class |

#### HTML Output
```html
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" href="/home" aria-current="page">Home</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/profile">Profile</a>
  </li>
</ul>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `NavItem` | `<li>` | `nav-item` | `NavItem.new(content = nil, **attributes, &)` |
| `NavLink` | `<a>` | `nav-link` | `NavLink.new(content = nil, href: "#", active: false, disabled: false, **attributes, &block)` |

#### Composition
```
Nav
├── NavItem
│   └── NavLink
├── NavItem
│   └── NavLink (active)
```

#### Usage Examples
```ruby
Nav.new(type: :pills) do |e|
  e << NavItem.new do |item|
    item << NavLink.new("Home", href: "/", active: true)
  end
  e << NavItem.new do |item|
    item << NavLink.new("Profile", href: "/profile")
  end
  e << NavItem.new do |item|
    item << NavLink.new("Disabled", href: "/disabled", disabled: true)
  end
end
```

---

### Navbar

| Property | Value |
|---|---|
| Class | `Navbar` |
| Tag | `<nav>` |

#### Public API
```ruby
Navbar.new(content = nil, expand: :lg, theme: :light, background: nil, fixed: nil, sticky: nil, container: true, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `expand` | Symbol | `:lg` | `:sm`, `:md`, `:lg`, `:xl`, `:xxl` |
| `theme` | Symbol | `:light` | `:light`, `:dark` |
| `background` | Symbol | `nil` | Any bg color (e.g., `:primary`, `:dark`) |
| `fixed` | Symbol | `nil` | `:top`, `:bottom` |
| `sticky` | Symbol | `nil` | `:top`, `:bottom` |
| `container` | Boolean/String | `true` | `true` uses `container-fluid`, String uses custom class |

#### HTML Output
```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Brand</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
      </ul>
    </div>
  </div>
</nav>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `NavbarBrand` | `<a>` | `navbar-brand` | `NavbarBrand.new(content = nil, href: "#", **attributes, &block)` |
| `NavbarToggler` | `<button>` (self-closing, with inner `<span>`) | `navbar-toggler` | `NavbarToggler.new(target: nil, **attributes)` |
| `NavbarCollapse` | `<div>` | `collapse navbar-collapse` | `NavbarCollapse.new(content = nil, id: nil, **attributes, &block)` |
| `NavbarNav` | `<ul>` | `navbar-nav` | `NavbarNav.new(content = nil, **attributes, &)` |

#### Composition
```
Navbar
├── <div class="container-fluid"> (if container: true)
│   ├── NavbarBrand
│   ├── NavbarToggler (target matches collapse id)
│   └── NavbarCollapse
│       └── NavbarNav
│           ├── NavItem → NavLink × N
│           └── ...other content
└── </div> (if container)
```

#### Usage Examples
```ruby
Navbar.new(expand: :lg, theme: :light, background: :light) do |e|
  e << NavbarBrand.new("MyApp", href: "/")
  e << NavbarToggler.new(target: "mainNav")
  e << NavbarCollapse.new(id: "mainNav") do |collapse|
    collapse << NavbarNav.new do |nav|
      nav << NavItem.new { |i| i << NavLink.new("Home", href: "/", active: true) }
      nav << NavItem.new { |i| i << NavLink.new("About", href: "/about") }
    end
  end
end
```

---

### Pagination

| Property | Value |
|---|---|
| Class | `Pagination` |
| Tag | `<nav>` |
| Inner wrapper | `<ul class="pagination">` |

#### Public API
```ruby
Pagination.new(content = nil, size: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `size` | Symbol | `nil` | `:sm`, `:lg` |

#### HTML Output
```html
<nav aria-label="Pagination">
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item active" aria-current="page"><a class="page-link" href="#">2</a></li>
    <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">3</a></li>
  </ul>
</nav>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `PageItem` | `<li>` | `page-item` | `PageItem.new(content, active: false, disabled: false, href: "#", **attributes, &block)` |

**PageItem details:**
- Always wraps content in `<a class="page-link">` via `wrap_content`
- Uses `@page_href` for the link's `href` attribute
- When `disabled`, adds `tabindex="-1"` to the link

#### Composition
```
Pagination (<nav>)
└── <ul class="pagination">
    └── PageItem × N
```

#### Usage Examples
```ruby
Pagination.new(size: :lg) do |e|
  e << PageItem.new("Previous", href: "/page/1")
  e << PageItem.new("1", href: "/page/1")
  e << PageItem.new("2", href: "/page/2", active: true)
  e << PageItem.new("3", href: "/page/3")
  e << PageItem.new("Next", href: "/page/3")
end
```

---

### Progress

| Property | Value |
|---|---|
| Class | `Progress` |
| Tag | `<div>` |
| Role | `role="progressbar"` |

#### Public API
```ruby
Progress.new(content = nil, **attributes, &)
```

#### HTML Output
```html
<div class="progress" role="progressbar">
  <div class="progress-bar" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%">50%</div>
</div>
```

#### Sub-components

| Component | Tag | CSS Class | Constructor |
|---|---|---|---|
| `ProgressBar` | `<div>` | `progress-bar` | `ProgressBar.new(content, value: 0, variant: nil, striped: false, animated: false, **attributes, &block)` |

**ProgressBar details:**
- `value`: 0–100, sets `aria-valuenow` and `style="width: {value}%"`
- `variant`: `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`
- `striped`: adds `.progress-bar-striped`
- `animated`: adds `.progress-bar-animated`

#### Composition
```
Progress
└── ProgressBar × N
```

#### Usage Examples
```ruby
Progress.new do |e|
  e << ProgressBar.new("50%", value: 50, variant: :success)
end

# Multiple bars
Progress.new do |e|
  e << ProgressBar.new(value: 30, variant: :info)
  e << ProgressBar.new(value: 20, variant: :warning)
end

# Striped and animated
Progress.new do |e|
  e << ProgressBar.new(value: 75, striped: true, animated: true)
end
```

---

### Spinner

| Property | Value |
|---|---|
| Class | `Spinner` |
| Tag | `<div>` |
| Role | `role="status"` |

#### Public API
```ruby
Spinner.new(content = nil, type: :border, variant: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `type` | Symbol | `:border` | `:border`, `:grow` |
| `variant` | Symbol | `nil` | `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark` |

#### HTML Output
```html
<div class="spinner-border" role="status">Loading...</div>
```

With `type: :grow`:
```html
<div class="spinner-grow" role="status">Loading...</div>
```

#### Sub-components
None (leaf component).

#### Composition
```
Spinner (no sub-components, content only)
```

#### Usage Examples
```ruby
Spinner.new("Loading...")
Spinner.new(type: :grow, variant: :primary)
Spinner.new(variant: :success) { |e| e << "Processing..." }
```

---

### Table

| Property | Value |
|---|---|
| Class | `Table` |
| Tag | `<table>` |

#### Public API
```ruby
Table.new(content = nil, striped: false, bordered: false, hover: false, small: false, variant: nil, **attributes, &block)
```

| Parameter | Type | Default | Values |
|---|---|---|---|
| `striped` | Boolean | `false` | Adds `.table-striped` |
| `bordered` | Boolean | `false` | Adds `.table-bordered` |
| `hover` | Boolean | `false` | Adds `.table-hover` |
| `small` | Boolean | `false` | Adds `.table-sm` |
| `variant` | Symbol | `nil` | `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark` |

#### HTML Output
```html
<table class="table table-striped table-hover">
  <thead><tr><th>Name</th><th>Age</th></tr></thead>
  <tbody><tr><td>John</td><td>30</td></tr></tbody>
</table>
```

#### Sub-components
None built-in (content is expected as raw HTML strings or Elements).

#### Composition
```
Table
└── Content (raw HTML strings, Elements)
```

#### Usage Examples
```ruby
Table.new(striped: true, hover: true) do |e|
  e << "<thead><tr><th>Name</th><th>Email</th></tr></thead>".html_safe
  e << "<tbody>".html_safe
  e << Element.new("tr") do |tr|
    tr << Element.new("td", "John Doe")
    tr << Element.new("td", "john@example.com")
  end
  e << "</tbody>".html_safe
end
```

---

## Element Usage Scenarios

### Basic Element Creation
```ruby
# Simple element
E.new("div", "Hello")
# => <div>Hello</div>

# With attributes
E.new("a", "Click", href: "/page", class: "link")
# => <a href="/page" class="link">Click</a>

# Self-closing (void element)
E.new("img", nil, closing_tag: false, src: "photo.jpg", alt: "Photo")
# => <img src="photo.jpg" alt="Photo">

# With CSS class as array value
E.new("div", class: ["container", "fluid"])
# => <div class="container fluid"></div>
```

### Content via Block (Eager Execution)
Blocks execute immediately — `@contents` is resolved at construction time:
```ruby
div = E.new("div") do |e|
  e << "text"
  e << E.new("span", "nested")
end

div.contents    # => ["text", <Element:span>]
div.render      # => "<div>text<span>nested</span></div>"
```

### Content + Block Combined
```ruby
E.new("div", "before") { |e| e << "after" }
# content argument is added before block content
# => "<div>beforeafter</div>"
```

### Array Content
```ruby
E.new("ul") do |e|
  e << ["<li>one</li>", "<li>two</li>"]
end
# Arrays are splatted into @contents
```

### Nested Elements
```ruby
E.new("div") do |e|
  e << E.new("ul") do |ul|
    ul << E.new("li", "item 1")
    ul << E.new("li", "item 2")
  end
end
# => <div><ul><li>item 1</li><li>item 2</li></ul></div>
```

### SafeString (HTML escaping bypass)
```ruby
E.new("div") do |e|
  e << "<strong>bold</strong>".html_safe
  e << E.new("span", "<escaped>")
end
# => "<div><strong>bold</strong><span>&lt;escaped&gt;</span></div>"
```

### Add Content Methods
```ruby
e = E.new("div")
e.add_content("first")
e.add_content(E.new("span", "second"))
e.add_content { |el| el << "third from block" }
e.render  # => "<div>first<span>second</span>third from block</div>"

# Shovel operator
e << "fourth"

# Reset and replace
e.add_content!("replacement")
```

### Attributes Management
```ruby
e = E.new("div")
e.add_attribute(class: "container")
e.add_attribute(class: "fluid")    # appends: class="container fluid"
e.add_attribute(id: "main")
e.remove_attribute_value(:class, "fluid")  # class="container"
e.remove_attribute(:id)                    # id removed

# Attributes hash structure:
# { class: ["container"], id: ["main"] }
# Rendered as: class="container" id="main"
```

### Chaining Methods
```ruby
E.new("div")
  .add_attribute(class: "card")
  .add_content("body")
  .html_safe
  .cache
```

### Conditional Tag Name
Useful when the same component needs to render as different tags:
```ruby
tag = conditional ? "a" : "span"
E.new(tag, "content", href: conditional ? "/link" : nil)
```

### Hooks (before_render, after_render, around_render)
Create a subclass to use hooks:
```ruby
class MyElement < ElementComponent::Element
  def initialize
    super("div", "content")
  end

  def before_render
    add_attribute(class: "processed")
  end

  def after_render(html)
    html.prepend("<!-- start -->")
    html << "<!-- end -->"
  end
end
```

### Caching
```ruby
e = E.new("div", "expensive content")
e.cache                   # cache with default key (hash)
e.cache(key: "my_key")    # custom key
e.cache(expires_in: 300)  # cache for 5 minutes (only works with Rails.cache)
e.render                  # subsequent calls return cached HTML
e.expire_cache!           # clear cache
```

### Rails Helpers
```ruby
class MyComponent
  include ElementComponent::RailsHelpers

  def render
    div = E.new("div")
    div.add_content(link_to("Home", "/"))  # delegates to view_context
    div.render
  end
end
```

### Creating Generic Elements with tag()
```ruby
ElementComponent.tag("div", "content", class: "box")
ElementComponent.tag("div", class: "box") { |e| e << "block content" }
```

### Namespace Aliases Summary
```ruby
# All four are equivalent:
ElementComponent::Element.new("div")
ElementComponent::E.new("div")
EC::E.new("div")
ElementComponent.tag("div")

# Component aliases:
ElementComponent::Components::Alert.new("msg")
ElementComponent::Alert.new("msg")
EC::Alert.new("msg")
```

## Composition Rules by Component

```
Leaf Components (no children):
  Badge, Button, ButtonGroup (contains Buttons as content),
  CloseButton, Spinner

Container Components (hold sub-components via add_content/<<):
  Alert → Heading, Link, CloseButton
  Breadcrumb → BreadcrumbItem × N
  Card → Header, Body, Footer, Title, Text, Image (any order)
  Carousel → CarouselItem × N
  Dropdown → Menu, Items, Dividers, Headers
  ListGroup → ListGroupItem × N
  Modal → ModalContent (which wraps Header, Body, Footer, Title)
  Nav → NavItem × N (which contain NavLink)
  Navbar → Brand, Toggler, Collapse (which contains NavbarNav → NavItem × N)
  Pagination → PageItem × N
  Progress → ProgressBar × N
  Table → raw HTML content

Component Hierarchy (nested):
  Navbar
    ├── NavbarBrand (leaf)
    ├── NavbarToggler (leaf, self-closing)
    └── NavbarCollapse
        └── NavbarNav
            └── NavItem
                └── NavLink (leaf)

  Dropdown
    ├── (toggle_button helper)
    └── DropdownMenu
        ├── DropdownItem
        ├── DropdownDivider
        └── DropdownHeader

  Card
    ├── CardImage (top)
    ├── CardHeader
    ├── CardBody
    │   ├── CardTitle
    │   └── CardText
    ├── CardFooter
    └── CardImage (bottom)

  Modal
    └── ModalDialog (auto-created)
        └── ModalContent
            ├── ModalHeader
            │   ├── ModalTitle
            │   └── CloseButton
            ├── ModalBody
            └── ModalFooter
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
- Contents stored as Array (supports strings, Elements, and Arrays of any of these)
- `add_content(content)` accepts a single value or an Array; Arrays are spread into `@contents`
- `!` suffix methods reset state before adding (e.g., `add_content!` clears then adds)
- **Blocks execute eagerly** — `block.call(self)` in `add_content`, NOT at render time
- `<<(content)` is an alias for `add_content(content)` returning `self`
- `render_content` no longer has a `when Proc` case (Procs are never stored in `@contents`)
- Hooks (`before_render`, `after_render`, `around_render`) are optional, detected via `respond_to?`
- Self-closing tags controlled by `closing_tag:` parameter
- Component classes use `add_attribute()` instead of direct hash manipulation
- `content` as first positional argument in all constructors (optional, default `nil`)
- Content argument is added before block content when both are provided
- All 48 components are aliased directly under `ElementComponent::` for convenience
- **HTML Escaping**: String content escaped via `CGI.escapeHTML` by default; `SafeString` (or `.html_safe`) marks content as safe to skip escaping
- **Attribute escaping**: Attribute values also escaped via `CGI.escapeHTML` in `mount_attributes`
- **No double-escape**: `Element#render` returns `SafeString`, so nested Elements are never re-escaped
- **Caching**: In-memory by default; uses `Rails.cache` when available. Enable via `element.cache`
- **Rails Helpers**: Optional `RailsHelpers` module with `method_missing` delegation to `view_context`
- `ElementComponent::E` is an alias for `ElementComponent::Element`
- `ElementComponent::EC` is an alias for `ElementComponent::Components`
- `ElementComponent.tag()` is a helper method for creating generic elements
- `ElementComponent::Shortcuts` module provides instance methods for use in views/helpers
