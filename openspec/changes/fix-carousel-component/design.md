## Context

`Carousel` (`lib/element_component/components/carousel.rb`) is the only component in the library
that assembles HTML with raw string interpolation. `indicator_button` and `control_button`
return hand-written `"<button ...>"` strings, and `build` is overridden to manually concatenate
`opening_tag`, an indicators block, a `carousel-inner` wrapper, `mount_content`, control buttons,
and `closing_tag`. Every other component instead subclasses `Element` and uses
`add_attribute`/`add_content`, delegating escaping to `Element#escape_html` and rendering to the
base `build`.

Consequences of the string approach:
- Interpolated values (`@carousel_id`, `index`, `direction`, `label`) are never escaped.
- `build_indicators` re-derives the item list and contains a dead `c.is_a?(Proc)` branch —
  `Element#add_content` calls blocks eagerly, so `@contents` never stores a `Proc`.
- The active-indicator logic `item.active? || index.zero?` marks the first indicator active even
  when a later item is the active one, producing two active indicators.

We just applied the same "use the builder, follow the standard constructor" fix to `Dropdown`,
so this change follows an established, recently-validated pattern.

## Goals / Non-Goals

**Goals:**
- Generate every part of the carousel through `Element`, so escaping is automatic and consistent
  with the rest of the library.
- Mark exactly one indicator active, tracking the active item.
- Use the standard `super("div", content, **attributes, &)` constructor and remove dead code.
- Preserve the public API and keep rendered output HTML-equivalent (modulo the escaping and
  active-indicator corrections), so existing specs keep passing.

**Non-Goals:**
- No new options or features (no `data-bs-ride` autoplay flag, no new interval/crossfade API) —
  callers can already pass arbitrary attributes like `data-bs-ride: "carousel"`.
- No changes to `CarouselItem` or `CarouselCaption`.

## Decisions

**1. Build indicators/controls with `Element`, not strings.**
Replace `indicator_button`/`control_button` string builders with `Element.new("button", ...)`
constructions (nested `span`s for the control icon and visually-hidden label). Rationale: the
builder escapes attribute values and text content centrally; alternative (escaping inline in the
string builders via `CGI.escapeHTML`) would work but keeps the divergent pattern and re-invents
what the base class already does.

**2. Render the indicators/inner/controls via content + a render hook instead of overriding `build`.**
Prefer assembling the structure using the public content API so the base `build`/`mount_content`
path handles items (and their `html_safe?`/`Element` rendering) uniformly. Two viable shapes:
  - (a) Override `build` but have it append `Element#render` output of builder-constructed
    indicator/control elements rather than raw strings; or
  - (b) Use a `before_render`/`template` hook to push the indicators wrapper, an inner wrapper
    Element holding the items, and the controls into `@contents`, then let the base `build` run.

  Decision: implement (a) as the minimal, low-risk step — keep the `build` override but make every
  appended fragment come from an `Element`, and route item rendering through the existing
  `mount_content(contents)`. This preserves ordering guarantees and existing tests while removing
  all raw HTML. (b) is noted as a possible follow-up refactor but is out of scope.

**3. Collect items by filtering `@contents` with `grep(CarouselItem)`; drop the `Proc` branch.**
Keep the simple `@contents.grep(CarouselItem)` to enumerate items for indicators. Remove the dead
`Proc`-flattening code. Rationale: blocks are already resolved into `@contents` by the time
`render` runs.

**4. Active-indicator logic: single active.**
Determine the active item index once: the index of the first item whose class list includes
`"active"`, falling back to `0` when none is active. Mark only that indicator active. Rationale:
matches Bootstrap's "one active indicator" contract and removes the `|| index.zero?` double-active
bug.

**5. Standard constructor.**
Change `super("div", &block)` + manual `add_attribute(attributes)` / `add_content(content)` to
`super("div", content, **attributes, &)`, then add the `id`/`carousel`/`slide`/`carousel-fade`
attributes. Mirrors the Dropdown fix.

## Risks / Trade-offs

- [Escaping changes exact output for unusual ids] → Existing specs use plain ids (`carousel`,
  `my-carousel`) that are unaffected; add a spec asserting a quote-bearing id is escaped.
- [Active-indicator change alters output when a non-first item is active] → The existing spec only
  asserts indicator count and presence of `active`; verify it still passes and add a spec pinning
  the single-active behavior so the fix is locked in.
- [Keeping the `build` override (decision 2a) still re-implements some base logic] → Accepted as
  the lower-risk path; all fragments now come from `Element`, and a fuller hook-based refactor is
  left as an explicit non-goal/follow-up.
