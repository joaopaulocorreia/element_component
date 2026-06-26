## Why

The `Carousel` component builds its indicators, controls, and outer markup by interpolating
values directly into raw HTML strings instead of using the library's own `Element` API. This
bypasses the centralized HTML escaping every other component relies on (a `"` in `id:` breaks
the markup and opens an injection vector) and duplicates rendering logic the base class already
provides. It also produces incorrect markup: a non-first active item yields two active
indicators.

## What Changes

- Rewrite `Carousel` so indicators, controls, and the inner wrapper are constructed with
  `Element` (the library's builder) instead of hand-built HTML strings. Escaping of `id`,
  indices, control direction, and labels is then handled by the library, closing the injection
  gap.
- Fix indicator active-state logic so exactly one indicator is marked `active`, matching the
  active item (no more forced first-indicator-active fallback producing duplicates).
- Align the constructor with the standard component pattern used elsewhere
  (`super("div", content, **attributes, &)`), removing the manual `add_attribute(attributes)` /
  `add_content(content)` dance.
- Remove the dead `Proc` branch in indicator collection (blocks are evaluated eagerly by
  `Element`, so `@contents` never holds a `Proc`) and lean on the base `build`/`mount_content`
  path rather than re-implementing `opening_tag`/`closing_tag`.
- No public API change: constructor signature, options (`id`, `fade`, `indicators`, `controls`),
  and sub-components (`CarouselItem`, `CarouselCaption`) are unchanged. Rendered output stays
  HTML-equivalent except for the corrected escaping and active-indicator fix.

## Capabilities

### New Capabilities
- `carousel`: Rendering contract for the Bootstrap 5 carousel component — its structure
  (indicators, inner items, controls), the options that toggle them, correct active-indicator
  behavior, and the requirement that all generated markup be produced through the library's
  escaped `Element` builder.

### Modified Capabilities
<!-- None: no existing specs in openspec/specs/. -->

## Impact

- `lib/element_component/components/carousel.rb` (primary rewrite).
- `spec/lib/components/carousel_spec.rb` (add coverage for escaping and active-indicator
  correctness; existing assertions should continue to pass).
- No changes to `carousel/item.rb`, `carousel/caption.rb`, or the public API.
- `CHANGELOG.md` entry under Unreleased.
