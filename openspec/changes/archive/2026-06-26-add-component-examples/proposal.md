## Why

The `examples/` directory is meant to be the runnable, copy-pasteable reference for every
component, but it has drifted from the implementation. Four components — `Container`, `Row`,
`Col`, and `Grid` (the entire layout family, and the part of the API with the most recent churn:
hash-based breakpoints, removed dynamic methods, the CSS-grid `d-grid` switch) — have no example
at all. And the `Dropdown` example hand-builds its toggle button instead of using the component's
own `toggle_button` helper, so it neither demonstrates nor exercises the intended API. Examples
that don't reflect the real API are worse than missing — they teach the wrong thing.

## What Changes

- Add four new example files so every public component has one: `container_example.rb`,
  `row_example.rb`, `col_example.rb`, `grid_example.rb`. Each demonstrates the component's
  **current** constructor options, including the scalar-or-hash breakpoint API.
- Correct `dropdown_example.rb` to use the `toggle_button` helper for most cases, while keeping
  **one** hand-built toggle to show the lower-level `Element` approach, and to pass dropdown-item
  labels as positional content so the text renders inside the link. (A `split: true` example is
  excluded — `toggle_button(split: true)` is currently broken and tracked as a separate fix.)
- Audit the remaining existing example files against their current constructor signatures and
  correct any drift found (options that no longer exist, missing key options).
- Keep the established verbose `ElementComponent::Components::X` namespacing and the existing
  file format (commented section banners, `puts "=== ... ==="`, `puts component.render`).
- Every example must run cleanly with `ruby examples/<name>.rb` and reflect the real output.

## Capabilities

### New Capabilities
- `component-examples`: The contract that every public component has a runnable example file in
  `examples/` which exercises that component's current public API and renders without error.

### Modified Capabilities
<!-- None: no existing specs in openspec/specs/. -->

## Impact

- New: `examples/{container,row,col,grid}_example.rb`.
- Modified: `examples/dropdown_example.rb` (and any others found drifting during the audit).
- No library code changes — examples consume the existing public API only.
- Reference only; no effect on the gem build or runtime behavior.
