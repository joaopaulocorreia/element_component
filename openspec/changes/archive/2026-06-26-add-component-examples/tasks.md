## 1. New layout examples

- [x] 1.1 Create `examples/container_example.rb` demonstrating `fluid: true`, `breakpoint:` (e.g. `:md`), and the default container.
- [x] 1.2 Create `examples/row_example.rb` demonstrating `cols:` (scalar and hash), `gutter:`, and `gutter_x:`/`gutter_y:`.
- [x] 1.3 Create `examples/col_example.rb` demonstrating the default `col`, `col:` (scalar and hash), `offset:`, and `order:`.
- [x] 1.4 Create `examples/grid_example.rb` demonstrating `gap:` (scalar and hash), `row_gap:`, and `column_gap:` (note `d-grid` output).
- [x] 1.5 Add a composed case (Container > Row > Cols) to show the layout pieces working together.

## 2. Correct the dropdown example

- [x] 2.1 Replace the hand-built toggle buttons in `examples/dropdown_example.rb` with `dropdown.toggle_button(label:, variant:)`.
- [x] 2.2 Pass dropdown-item labels as positional content (`DropdownItem.new("Label")`) so text renders inside the link, not beside it. (`split: true` example descoped — `toggle_button(split:)` is broken; flagged as a separate fix. Also dropped the misleading `type: :button` item section — `DropdownItem` has no `type:` param.)
- [x] 2.3 Keep exactly one section that builds the toggle by hand with `Element` to document the lower-level approach.

## 3. Audit existing examples for API drift

- [x] 3.1 Read each remaining `examples/*.rb` against its component's current constructor signature; confirm every passed keyword is a real constructor option (not silently absorbed as an HTML attribute).
- [x] 3.2 Correct any drift found; otherwise confirm alignment. Found and fixed: `nav` (`type:` → `variant:`), `breadcrumb` (item `href:` absorbed onto `<li>` → wrap an anchor `Element` as content), `modal` (`scrollable:`/`centered:`/`size:` belong on `ModalDialog`, not `Modal` → introduced the `ModalDialog` wrapper). The other examples (alert, badge, button_group, card, carousel, close_button, list_group, navbar, pagination, progress, spinner, table) were confirmed aligned.

## 4. Conventions and verification

- [x] 4.1 Ensure each new file uses `# frozen_string_literal: true`, `require_relative "../lib/element_component"`, verbose `ElementComponent::Components::X` namespacing, and the banner/`puts render` format.
- [x] 4.2 Run every `examples/*.rb` with `ruby` and confirm each exits zero and renders the expected output. (All 21 exit 0; full coverage — every component has an example.)
- [x] 4.3 Run `bundle exec rubocop examples/` and resolve any offenses in new/changed files. (21 files, no offenses.)
