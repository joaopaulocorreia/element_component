## Context

`examples/` holds one `<component>_example.rb` per component: each requires the library, then
prints rendered output for a series of cases under `puts "=== ... ==="` banners. 17 of 21
components have such a file; all 17 currently run without error. The gaps are (a) the four layout
components have no file, and (b) `dropdown_example.rb` hand-rolls its toggle button instead of
using `Dropdown#toggle_button`. The layout family is also the most-churned API in recent history
(hash breakpoints, removed dynamic methods, `grid` → `d-grid`), so its examples must pin the
*current* API precisely.

## Goals / Non-Goals

**Goals:**
- One runnable example per public component (close the 4-file gap).
- Examples that exercise the real, current constructor options and helpers.
- Correct the dropdown example to feature `toggle_button` (+ one manual toggle retained).
- Preserve verbose namespacing and the existing file format.

**Non-Goals:**
- No library/source code changes; no new components (e.g. no Thead/Tr/Td — table content stays
  as raw HTML strings, which is the only option today).
- No README rewrite and no migration to the short aliases (`EC::`, `Shortcuts`) — that is a
  separate concern.
- No new component options or behavior.

## Decisions

**1. Mirror the existing example template exactly.**
Each new file: `# frozen_string_literal: true`, `require_relative "../lib/element_component"`,
then `# ===` banner blocks with `puts "=== Label ==="` / `puts component.render`. Rationale:
consistency with the other 17 files; the format is the project's de-facto example contract.

**2. Pin the current breakpoint API in the layout examples.**
Use the verified constructor signatures (below). Show each breakpoint-aware option in both scalar
and hash form so the file doubles as documentation of the post-churn API.

```
Container.new(fluid: true)                         # container-fluid
Container.new(breakpoint: :md)                      # container-md
Container.new                                       # container

Row.new(cols: 3)                                    # row-cols-3
Row.new(cols: { default: 1, md: 2, lg: 4 })         # row-cols-1 row-cols-md-2 row-cols-lg-4
Row.new(gutter: 3)                                  # g-3
Row.new(gutter_x: 5, gutter_y: 2)                   # gx-5 gy-2

Col.new                                             # col
Col.new(col: 6)                                     # col-6
Col.new(col: { md: 4 }, offset: 2)                  # col-md-4 offset-2
Col.new(order: { default: 2, lg: 1 })               # order-2 order-lg-1

Grid.new(gap: 3)                                     # d-grid gap-3
Grid.new(row_gap: 2, column_gap: 4)                 # d-grid row-gap-2 column-gap-4
Grid.new(gap: { default: 2, md: 4 })                # d-grid gap-2 gap-md-4
```

Realistic composition case: a `Row` containing `Col`s (and a `Container` wrapping a `Row`) so the
layout pieces are shown working together, not just in isolation.

**3. Dropdown: helper-first, one manual.**
Replace the repeated hand-built `Element.new("button", class: "...dropdown-toggle"...)` blocks
with `dropdown.toggle_button(label:, variant:)`, and keep exactly one section that builds the
toggle by hand to document the lower-level path. Pass dropdown-item labels as positional content
(`DropdownItem.new("Label")`); the block form renders the text outside the link and is incorrect
usage. A `split: true` example is **descoped**: `toggle_button(split: true)` currently misbinds its
block bodies to the dropdown instead of the button group and renders broken markup. Fixing it is a
library change, out of scope for this examples-only change, and is flagged as a separate fix.

**4. Audit, don't assume, for the other 16.**
During implementation, read each existing example against its constructor signature and fix any
drift (an option that is no longer a real keyword, or a missing primary option). The spot-check so
far found the existing 16 aligned, so this is expected to be confirmation plus the dropdown fix.

## Risks / Trade-offs

- [Examples drift again as the API evolves] → Mitigation: a lightweight spec/CI check that runs
  every `examples/*.rb` and asserts exit zero would keep them honest. Proposed as a follow-up;
  the tasks include running all examples manually as the acceptance gate for now.
- [Hash-breakpoint output is easy to get subtly wrong] → Mitigation: each new example's expected
  class string is listed above and should be eyeballed against actual rendered output.
