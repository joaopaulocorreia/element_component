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
spec/
  element_component_spec.rb         # Version check
  lib/
    element_spec.rb                 # Element unit tests
    components/
      alert_spec.rb                 # Alert component tests
  spec_helper.rb                    # RSpec config
examples/
  alert_example.rb                  # Complete Alert usage examples
```

## Core Classes

### `ElementComponent::Element`
- **Attributes**: `element` (tag name), `attributes` (Hash), `contents` (Array), `html` (rendered output)
- **Constructor**: `Element.new(tag_name, closing_tag: true, **attributes)`
- **Content methods**: `add_content`, `add_content!`, `add_content(&block)`
- **Attribute methods**: `add_attribute`, `add_attribute!`, `remove_attribute`, `remove_attribute_value`
- **Render**: `render` (with hooks: `before_render`, `after_render`, `around_render`)

### Pre-built Components

Components live under `ElementComponent::Components`. Each component folder contains the main class and its sub-components in separate files.

| Component | Class | Description |
|---|---|---|
| Alert | `Components::Alert` | `.alert` container with context |
| Alert Heading | `Components::AlertHeading` | `.alert-heading` (`<h4>`) |
| Alert Link | `Components::AlertLink` | `.alert-link` (`<a>`) |
| Alert Close | `Components::AlertCloseButton` | `.btn-close` (self-closing `<button>`) |

**Alert constructor**: `Alert.new(context: :primary, dismissible: false, **attributes, &block)`
- `context`: one of `:primary`, `:secondary`, `:success`, `:danger`, `:warning`, `:info`, `:light`, `:dark`
- `dismissible`: adds `.alert-dismissible` class and appends a `CloseButton`
- `&block`: instance_eval DSL for adding content inside the element

**Component guidelines**:
- Always use `add_attribute()` instead of manipulating the `attributes` hash directly
- Each class in its own file under a component-named folder
- Call `super("tag_name", closing_tag: ..., &block)` first, then chain `add_attribute` calls
- `instance_eval(&block)` lives in `Element#initialize` — do NOT repeat it in components
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
- Contents stored as Array (supports strings, Elements, and Procs/blocks)
- `!` suffix methods reset state before adding (e.g., `add_content!` clears then adds)
- Hooks (`before_render`, `after_render`, `around_render`) are optional, detected via `respond_to?`
- Self-closing tags controlled by `closing_tag:` parameter
- Component classes use `add_attribute()` instead of direct hash manipulation

## Roadmap Features (from README)
- Caching support
- Pre-built Bulma components
- Pre-built Bootstrap components
- Enhanced DSL for nested structures
