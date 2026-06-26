# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- `Rails.cache` rendering now actually caches: a cache hit returns the stored HTML
  and skips the rebuild, instead of rebuilding on every `render` and discarding the
  cached value.
- `Carousel` now builds its indicators and controls through the `Element` builder
  instead of raw HTML strings, so interpolated values (notably `id`) are escaped.
  It also marks exactly one indicator active (matching the active item) instead of
  sometimes producing two active indicators.

### Added

- Option validation for component arguments. `Button` (`variant`, `size`),
  `Table` (`variant`), `Dropdown` (`direction`), and `Container` (`breakpoint`) now
  raise `ArgumentError` on an out-of-range value instead of emitting a broken
  Bootstrap class.

### Changed

- `Dropdown#initialize` now follows the standard component construction pattern,
  forwarding `content` and attributes through `super`.
- `apply_breakpoint_classes` moved into `BreakpointHelper`, removing duplicated
  copies from `Row`, `Col`, and `Grid`. `Container` reuses `BreakpointHelper`'s
  `VALID_BREAKPOINTS` rather than its own copy.
- CI now runs `push` builds on the `main` branch (was `master`).

## [1.14.0]

- Baseline release prior to this changelog. See the
  [GitHub releases](https://github.com/joaopaulocorreia/element_component/releases)
  for earlier history.
