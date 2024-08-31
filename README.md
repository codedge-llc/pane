# Pane

> Paginated data viewer for IEx. Written for [scribe](https://github.com/codedge-llc/scribe).
> Useful for inspecting large collections and deeply nested structs.

[![CI](https://github.com/codedge-llc/pane/actions/workflows/ci.yml/badge.svg)](https://github.com/codedge-llc/pane/actions/workflows/ci.yml)
[![Version](https://img.shields.io/hexpm/v/pane.svg)](https://hex.pm/packages/pane)
[![Total Downloads](https://img.shields.io/hexpm/dt/pane.svg)](https://hex.pm/packages/pane)
[![License](https://img.shields.io/hexpm/l/pane.svg)](https://github.com/codedge-llc/pane/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/codedge-llc/pane.svg)](https://github.com/codedge-llc/pane/commits/master)
[![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/pane/)

## Installation

Add `:pane` as a `mix.exs` dependency:

```elixir
def deps do
  [
    {:pane, "~> 0.5.0"}
  ]
end
```

## Usage

    iex> data =  File.read!("mix.exs") # Or some other really long string
    iex> Pane.console(data)

![console](https://raw.githubusercontent.com/codedge-llc/pane/master/docs/console.png)

## Available Commands

- `j` - Next page
- `k` - Previous page
- `f` - First page
- `l` - Last page
- `q` - Quit

## Contributing

### Testing

Unit tests can be run with `mix test` or `mix coveralls.html`.

### Formatting

This project uses Elixir's `mix format` and [Prettier](https://prettier.io) for formatting.
Add hooks in your editor of choice to run it after a save. Be sure it respects this project's
`.formatter.exs`.

### Commits

Git commit subjects use the [Karma style](http://karma-runner.github.io/5.0/dev/git-commit-msg.html).

## License

Copyright (c) 2017-2024 Codedge LLC (https://www.codedge.io/)

This library is MIT licensed. See the [LICENSE](https://github.com/codedge-llc/pane/blob/master/LICENSE) for details.
