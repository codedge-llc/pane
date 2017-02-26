defmodule Pane.Page do
  defstruct data: nil, index: nil

  @max_lines 50

  @type t :: %__MODULE__{
    data: String.t,
    index: pos_integer
  }

  @doc ~S"""
  Constructs new `Pane.Page` given data and index.

  ## Examples

      iex> Pane.Page.new("test", 1)
      %Pane.Page{data: "test", index: 1}
  """
  @spec new(String.t, pos_integer) :: t
  def new(data, index) do
    %__MODULE__{
      data: data,
      index: index
    }
  end

  @doc ~S"""
  Splits data on the newline and chunks it into `Pane.Page` structs.

  ## Examples

      iex> [p1] = Enum.join(1..4, "\n") |> Pane.Page.paginate
      iex> p1.index
      0
      iex> p1.data
      "1\n2\n3\n4"
  """
  @spec paginate(String.t, pos_integer) :: [t]
  def paginate(data, max_lines \\ @max_lines) do
    data
    |> String.split("\n")
    |> Enum.chunk(max_lines, max_lines, [])
    |> Enum.map(&Enum.join(&1, "\n"))
    |> Enum.with_index
    |> Enum.map(fn({data, index}) -> new(data, index) end)
  end
end
