# Pane

[![Module Version](https://img.shields.io/hexpm/v/pane.svg)](https://hex.pm/packages/pane)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/pane/)
[![Total Download](https://img.shields.io/hexpm/dt/pane.svg)](https://hex.pm/packages/pane)
[![License](https://img.shields.io/hexpm/l/pane.svg)](https://github.com/codedge-llc/pane/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/codedge-llc/pane.svg)](https://github.com/codedge-llc/pane/commits/master)

Paginated data viewer for IEx. Written for [scribe](https://github.com/codedge-llc/scribe).
Useful for inspecting large collections and deeply nested structs.

## Installation

Add `:pane` as a `mix.exs` dependency:

```elixir
def deps do
  [
    {:pane, "~> 0.4.1"}
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

## Copyright and License

Copyright (c) 2017 Codedge LLC (https://www.codedge.io/)

This library is released under the MIT License. See the [LICENSE.md](./LICENSE.md) file
for further details.
