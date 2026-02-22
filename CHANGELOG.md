# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.1] - 2026-02-22

### Added

- Better documented typespecs.
- Unit tests for `Pane.Page` and `Pane.Viewer`.

### Fixed

- Terminal size detection on Windows (replaced `tput` with `:io.rows/0`).

## [0.5.0] - 2024-08-31

### Changed

- Various documentation updates ([#5](https://github.com/codedge-llc/pane/pull/5)).
- Bumped minimum Elixir version to 1.13.

## [0.4.1] - 2021-02-27

### Fixed

- Include `:iex` in `:extra_applications` to remove compile warning.

## [0.4.0] - 2020-09-28

### Changed

- Bump minimum Elixir version to 1.5.

### Fixed

- Remove deprecated compile warnings.

## [0.3.0] - 2018-01-18

- Support for (f)first and (l)last page

## [0.2.0] - 2018-01-03

- Prompt to enable ANSI codes if disabled

## [0.1.1] - 2017-03-16

- Fix: crash on invalid key command

## [0.1.0] - 2017-02-26

- Initial release
