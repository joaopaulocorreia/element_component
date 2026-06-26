## ADDED Requirements

### Requirement: Every public component has a runnable example

Each public component under `ElementComponent::Components` SHALL have a corresponding example
file in `examples/` named `<component>_example.rb`. Each example file SHALL run to completion
with `ruby examples/<component>_example.rb` and exit zero, printing the rendered HTML for the
cases it demonstrates.

#### Scenario: Layout components have examples

- **WHEN** the `examples/` directory is listed
- **THEN** it contains `container_example.rb`, `row_example.rb`, `col_example.rb`, and
  `grid_example.rb`

#### Scenario: Every example runs without error

- **WHEN** each file in `examples/` is executed with `ruby`
- **THEN** it exits with status zero and produces rendered output

### Requirement: Examples reflect the current component API

Examples SHALL use only constructor options and helper methods that exist on the current
component, and SHALL demonstrate that component's primary options. An option passed to a
component constructor SHALL be a real keyword of that constructor, not a value silently absorbed
as an HTML attribute.

#### Scenario: Layout examples use the current breakpoint API

- **WHEN** the `row`, `col`, and `grid` examples are read
- **THEN** breakpoint-aware options (`cols`, `gutter`, `col`, `offset`, `order`, `gap`,
  `row_gap`, `column_gap`) are shown in both scalar and `{ breakpoint => value }` hash forms
- **AND** the grid example shows the `d-grid` based output

#### Scenario: Dropdown example uses the toggle_button helper

- **WHEN** `dropdown_example.rb` is read
- **THEN** it uses `Dropdown#toggle_button` for the majority of toggles
- **AND** it retains exactly one hand-built toggle using `Element` to show the lower-level approach
- **AND** dropdown items pass their label as positional content (`DropdownItem.new("Label")`) so the
  text renders inside the link, not beside it

> Note: a `split: true` example is intentionally excluded — `Dropdown#toggle_button(split: true)`
> currently renders broken markup and is tracked as a separate component fix. This change is
> examples-only and makes no library changes.

### Requirement: Examples follow the established format and style

Example files SHALL use the verbose `ElementComponent::Components::X` namespacing and match the
existing file conventions: a `# frozen_string_literal: true` magic comment, `require_relative
"../lib/element_component"`, commented section banners, and `puts "=== <label> ==="` followed by
`puts component.render` for each demonstrated case.

#### Scenario: New examples match existing conventions

- **WHEN** a newly added example file is read
- **THEN** it begins with the frozen-string-literal comment and the relative require
- **AND** it uses the verbose component namespacing and the banner/`puts render` format
