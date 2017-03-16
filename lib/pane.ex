defmodule Pane do
  @moduledoc """
  Paginated data viewer for IEx. Useful for inspecting large collections and
  deeply nested structs.

  ## Usage

      iex> data =  File.read!("mix.exs") # Or some other really long string
      iex> Pane.console(data)

  ![console][/docs/console.png]

  ## Available Commands
  * `j` - Next page
  * `k` - Previous page
  * `q` - Quit
  """

  @doc ~S"""
  Paginates data and starts a pseudo-interactive console.
  """
  def console(data) when is_binary(data) do
    Pane.Viewer.start_link(data: data)
    recv_input()
  end
  def console(data), do: data |> inspect(pretty: true) |> console()

  defp recv_input do
    IEx.Helpers.clear
    IO.puts Pane.Viewer.current_page.data

    input = "\n" <> Pane.Viewer.prompt |> IO.gets
    process(input)
  end

  defp process(input) do
    case input do
      "j\n" -> Pane.Viewer.next_page
      "k\n" -> Pane.Viewer.prev_page
      "q\n" ->
        Pane.Viewer.stop
        IEx.Helpers.clear
      _ -> Pane.Viewer.current_page
    end

    if input != "q\n" do recv_input() else :ok end
  end
end
