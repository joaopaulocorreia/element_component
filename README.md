# ElementComponent

A lightweight and flexible HTML builder for Ruby. `ElementComponent` provides a simple, object-oriented way to construct HTML structures programmatically, with dynamic attribute management, content nesting, rendering hooks, and pre-built components.

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

## Pre-built Components

Components live under `ElementComponent::Components`.

### Alert (Bootstrap 5)

```ruby
alert = ElementComponent::Components::Alert.new(context: :success) do
  add_content("Operation completed!")
end
puts alert.render
# => <div class="alert alert-success" role="alert">Operation completed!</div>
```

**Contexts**: `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`

#### Dismissible Alert

```ruby
alert = ElementComponent::Components::Alert.new(context: :warning, dismissible: true) do
  add_content("This can be closed.")
end
puts alert.render
# => <div class="alert alert-warning alert-dismissible" role="alert">
#      This can be closed.
#      <button class="btn-close" data-bs-dismiss="alert" aria-label="Close">
#    </div>
```

#### Alert with Heading and Link

```ruby
alert = ElementComponent::Components::Alert.new(context: :info) do
  add_content(ElementComponent::Components::AlertHeading.new.tap { |h| h.add_content("Notice") })
  add_content("Please review. ")
  add_content(ElementComponent::Components::AlertLink.new(href: "/details").tap { |l| l.add_content("Details") })
end
puts alert.render
# => <div class="alert alert-info" role="alert">
#      <h4 class="alert-heading">Notice</h4>
#      Please review.
#      <a class="alert-link" href="/details">Details</a>
#    </div>
```

#### Sub-components

| Class | Tag | Class |
|---|---|---|
| `Alert` | `<div>` | `.alert .alert-{context}` |
| `AlertHeading` | `<h4>` | `.alert-heading` |
| `AlertLink` | `<a>` | `.alert-link` |
| `AlertCloseButton` | `<button>` (self-closing) | `.btn-close` |

## Development

```bash
bin/setup              # Install dependencies
bundle exec rspec      # Run tests
bundle exec rubocop    # Lint
bundle exec rake       # Spec + RuboCop
bin/console            # Interactive console
ruby examples/alert_example.rb  # Run Alert examples
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
- [ ] Pre-built Bootstrap components (more)
- [ ] Enhanced DSL for nested structures

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joaopaulocorreia/element_component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
