defmodule Pane.Viewer do
  defstruct pages: [], index: 0

  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    pages = opts[:data] |> Pane.Page.paginate(max_lines() - 2)
    {:ok, %__MODULE__{
      index: 0,
      pages: pages 
    }}
  end

  def next_page, do: GenServer.call(__MODULE__, :next_page)

  def prev_page, do: GenServer.call(__MODULE__, :prev_page)

  def current_page, do: GenServer.call(__MODULE__, :current_page)

  def prompt, do: GenServer.call(__MODULE__, :prompt)

  def handle_call(:next_page, _from, state) do
    state = inc_page(state)
    current = current_page(state)
    IO.puts(current.data)

    {:reply, current, state}
  end

  def handle_call(:prev_page, _from, state) do
    state = dec_page(state)
    current = current_page(state)
    IO.puts(current.data)

    {:reply, current, state}
  end

  def handle_call(:current_page, _from, state) do
    {:reply, current_page(state), state}
  end

  def handle_call(:prompt, _from, state), do: {:reply, prompt(state), state}

  def current_page(state), do: Enum.at(state.pages, state.index)

  def last_page_index(state), do: Enum.count(state.pages) - 1

  def inc_page(state) do
    cond do
      state.index < last_page_index(state) -> %{state | index: state.index + 1}
      true -> state
    end
  end

  def dec_page(state) do
    cond do
      state.index > 0 -> %{state | index: state.index - 1}
      true -> state
    end
  end

  def page_description(state), do: "#{state.index + 1} of #{last_page_index(state) + 1}"

  def prompt(state), do: "[#{page_description(state)}] (j)next (k)prev (q)quit "

  def max_lines do
    case System.cmd("tput", ["lines"]) do
      {count, 0} -> count |> String.trim |> String.to_integer
    end
  end
end
