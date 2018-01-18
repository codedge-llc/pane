[![Hex.pm](http://img.shields.io/hexpm/v/pane.svg)](https://hex.pm/packages/pane)
[![Hex.pm](http://img.shields.io/hexpm/dt/pane.svg)](https://hex.pm/packages/pane)

# Pane
Paginated data viewer for IEx. Written for [scribe](https://github.com/codedge-llc/scribe). Useful for inspecting large collections and
deeply nested structs.


## Installation

Add pane as a `mix.exs` dependency:
```elixir
def deps do
  [{:pane, "~> 0.2.0"}]
end
```

## Usage

    iex> data =  File.read!("mix.exs") # Or some other really long string
    iex> Pane.console(data)

![console](https://raw.githubusercontent.com/codedge-llc/pane/master/docs/console.png)

## Available Commands
* `j` - Next page
* `k` - Previous page
* `f` - First page
* `l` - Last page
* `q` - Quit
