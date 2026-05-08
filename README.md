# ElementComponent

A lightweight and flexible HTML builder for Ruby. `ElementComponent` provides a simple, object-oriented way to construct HTML structures programmatically, allowing for dynamic attribute management and content nesting.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add element_component
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install element_component
```

## Usage

### Basic Usage

Create a simple element and render it to HTML:

```ruby
p = ElementComponent::Element.new("p", class: "text-bold")
p.add_content("Hello, World!")
puts p.render
# => <p class="text-bold">Hello, World!</p>
```

### Nesting Elements

You can nest elements by adding another `ElementComponent::Element` instance as content:

```ruby
div = ElementComponent::Element.new("div", class: "container")
h1  = ElementComponent::Element.new("h1")
h1.add_content("Welcome")

div.add_content(h1)
div.add_content("This is a simple HTML builder.")

puts div.render
# => <div class="container"><h1>Welcome</h1>This is a simple HTML builder.</div>
```

### Attribute Management

`ElementComponent` allows for easy manipulation of HTML attributes:

```ruby
btn = ElementComponent::Element.new("button", class: "btn", type: "button")

# Add more values to an attribute (e.g., adding another class)
btn.add_attribute(class: "btn-primary")

# Reset attributes and set new ones
btn.add_attribute!(id: "submit-btn", type: "submit")

# Remove an attribute
btn.remove_attribute(:type)

# Remove a specific value from an attribute
btn.remove_attribute_value(:class, "btn-primary")
```

### Self-Closing Tags

You can specify if an element should have a closing tag:

```ruby
img = ElementComponent::Element.new("img", closing_tag: false, src: "image.png", alt: "Logo")
puts img.render
# => <img src="image.png" alt="Logo">
```

### Rendering Hooks

`ElementComponent` supports `before_render`, `after_render`, and `around_render` hooks if implemented in a subclass or by extending an instance.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Roadmap

- [ ] Support for Caching
- [ ] Pre-built Bulma components
- [ ] Pre-built Bootstrap components
- [ ] Enhanced DSL for nested structures

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joaopaulocorreia/element_component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
