defmodule Pane.Viewer do
  @moduledoc false

  defstruct pages: [], total_pages: 0, index: 0

  use GenServer

  @doc ~S"""
  Starts a `Pane.Viewer` with given opts.


  ## Examples

      iex> {:ok, pid} = Pane.Viewer.start_link(data: "test")
      iex> is_pid(pid)
      true
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def stop, do: GenServer.stop(__MODULE__)

  @doc ~S"""
  Returns a `Pane.Viewer` struct with given opts.

  ## Examples

      iex> Pane.Viewer.init(data: "test")
      {:ok, %Pane.Viewer{
        index: 0,
        total_pages: 1,
        pages: [
          %Pane.Page{
            data: "test",
            index: 0
          }
        ]
      }}
  """
  def init(opts) do
    pages = opts[:data] |> Pane.Page.paginate(max_lines() - 2)

    state = %__MODULE__{
      index: 0,
      total_pages: Enum.count(pages),
      pages: pages
    }

    {:ok, state}
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

  def inc_page(%{index: i, total_pages: total} = state) when i < total - 1 do
    %{state | index: state.index + 1}
  end

  def inc_page(state), do: state

  def dec_page(%{index: i} = state) when i > 0 do
    %{state | index: i - 1}
  end

  def dec_page(state), do: state

  def page_description(state) do
    "#{state.index + 1} of #{last_page_index(state) + 1}"
  end

  def prompt(state), do: "[#{page_description(state)}] (j)next (k)prev (q)quit "

  def max_lines do
    case System.cmd("tput", ["lines"]) do
      {count, 0} -> count |> String.trim() |> String.to_integer()
    end
  end
end
