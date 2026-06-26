# carousel Specification

## Purpose
TBD - created by archiving change fix-carousel-component. Update Purpose after archive.
## Requirements
### Requirement: Markup is generated through the escaped Element builder

The `Carousel` component SHALL construct all of its generated markup — the indicator buttons,
the previous/next control buttons, the indicators wrapper, and the inner wrapper — using the
library's `Element` builder rather than hand-assembled HTML strings. Any value interpolated into
an attribute or text node (carousel `id`, slide index, control direction, control label) SHALL be
escaped by the same `Element` path used by every other component.

#### Scenario: Carousel id is escaped in generated attributes

- **WHEN** a `Carousel` is created with `id: 'a"b'` and rendered
- **THEN** the rendered `data-bs-target` and `id` attributes contain the escaped form of the id
- **AND** the raw sequence `#a"b` does not appear unescaped inside an attribute value

#### Scenario: Control labels are escaped

- **WHEN** a carousel with controls is rendered
- **THEN** the visually-hidden control labels are emitted as escaped text content via the builder

### Requirement: Carousel renders the standard Bootstrap structure

The `Carousel` component SHALL render an outer `div` carrying `id`, `carousel`, and `slide`
classes (plus `carousel-fade` when `fade` is enabled), containing — in order — an optional
`carousel-indicators` block, a `carousel-inner` wrapper holding the carousel items, and optional
previous/next controls.

#### Scenario: Default carousel structure

- **WHEN** a `Carousel` is rendered with default options
- **THEN** the output contains a `carousel slide` outer element with the configured `id`
- **AND** it contains a `carousel-indicators` block, a `carousel-inner` wrapper, and
  `carousel-control-prev` / `carousel-control-next` controls

#### Scenario: Indicators disabled

- **WHEN** a `Carousel` is rendered with `indicators: false`
- **THEN** the output does not contain a `carousel-indicators` block

#### Scenario: Controls disabled

- **WHEN** a `Carousel` is rendered with `controls: false`
- **THEN** the output does not contain `carousel-control-prev` or `carousel-control-next`

#### Scenario: Fade effect

- **WHEN** a `Carousel` is rendered with `fade: true`
- **THEN** the outer element carries the `carousel-fade` class

### Requirement: One indicator per item with a single active indicator

The `Carousel` component SHALL render exactly one indicator button per `CarouselItem` it
contains, in order. Exactly one indicator SHALL be marked active, corresponding to the item that
carries the active state; if no item is active, the first indicator SHALL be the active one.

#### Scenario: One indicator per item

- **WHEN** a carousel containing two `CarouselItem`s is rendered with indicators enabled
- **THEN** the output contains exactly two indicator buttons with `data-bs-slide-to`

#### Scenario: Active indicator follows the active item

- **WHEN** a carousel's second item is the active one
- **THEN** only the indicator for the second item is marked `active`
- **AND** the first indicator is not marked `active`

#### Scenario: Falls back to first indicator when no item is active

- **WHEN** a carousel has no active item
- **THEN** only the first indicator is marked `active`

### Requirement: Standard constructor and public API are preserved

The `Carousel` component SHALL accept content positionally, a block, and arbitrary HTML
attributes, forwarding them through the base `Element` constructor in the same way as other
components. The options `id`, `fade`, `indicators`, and `controls`, and the sub-components
`CarouselItem` and `CarouselCaption`, SHALL remain unchanged.

#### Scenario: Custom attributes are forwarded

- **WHEN** a `Carousel` is created with an extra HTML attribute (e.g. `data-bs-ride: 'carousel'`)
- **THEN** that attribute appears on the rendered outer element

#### Scenario: Block-provided items render inside carousel-inner

- **WHEN** carousel items are supplied via a block
- **THEN** they are rendered inside the `carousel-inner` wrapper

