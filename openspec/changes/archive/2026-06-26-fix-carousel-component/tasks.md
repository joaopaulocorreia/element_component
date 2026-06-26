## 1. Constructor alignment

- [x] 1.1 Change `Carousel#initialize` to `super("div", content, **attributes, &)`, removing the manual `add_attribute(attributes)` and `add_content(content)` calls (mirror the Dropdown pattern).
- [x] 1.2 Keep setting the `id`, `carousel`, `slide`, and conditional `carousel-fade` classes after `super`.

## 2. Builder-based indicators and controls

- [x] 2.1 Rewrite `indicator_button` to construct the button with `Element.new("button", ...)` (type, `data-bs-target`, `data-bs-slide-to`, and `active` class + `aria-current` when active), returning its rendered output — no raw HTML strings.
- [x] 2.2 Rewrite `control_button` to build the control button and its nested icon `span` and visually-hidden label `span` with `Element`, so the direction and label are escaped by the builder.
- [x] 2.3 Update the `build` override so every appended fragment (indicators wrapper, `carousel-inner` wrapper, controls) is produced via `Element`; route items through the inner wrapper Element.

## 3. Item collection and active-indicator fix

- [x] 3.1 Replace the `@contents` flat-map/`Proc` logic in `build_indicators` with `@contents.grep(CarouselItem)`; delete the dead `Proc` branch.
- [x] 3.2 Compute a single active index (first item whose class list includes `"active"`, else `0`) and mark only that indicator active, removing the `|| index.zero?` double-active bug.

## 4. Tests

- [x] 4.1 Add a spec asserting a carousel `id` containing a quote is escaped in `id`/`data-bs-target` (no unescaped injection).
- [x] 4.2 Add a spec asserting exactly one indicator is `active` when a non-first item is the active one, and that the first indicator is active when none is.
- [x] 4.3 Add a spec asserting one indicator per item and that custom attributes (e.g. `data-bs-ride`) are forwarded to the outer element.
- [x] 4.4 Confirm existing `carousel_spec.rb` assertions still pass unchanged.

## 5. Verification and docs

- [x] 5.1 Run `bundle exec rspec`, `COVERAGE=true bundle exec rspec`, and `bundle exec rubocop` — all green, coverage gates satisfied.
- [x] 5.2 Add a `CHANGELOG.md` entry under Unreleased describing the carousel escaping/active-indicator fix and builder migration.
