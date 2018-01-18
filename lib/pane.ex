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
    if IO.ANSI.enabled?() do
      start_and_recv(data)
    else
      prompt = "Pane requires ANSI escape codes to work. Enable? (Yn) "

      case IO.gets(prompt) do
        "Y" <> _rest -> enable_ansi_and_start(data)
        "y" <> _rest -> enable_ansi_and_start(data)
        _ -> :ok
      end
    end
  end

  def console(data), do: data |> inspect(pretty: true) |> console()

  defp enable_ansi_and_start(data) do
    Application.put_env(:elixir, :ansi_enabled, true)
    start_and_recv(data)
  end

  defp start_and_recv(data) do
    Pane.Viewer.start_link(data: data)
    recv_input()
  end

  defp recv_input do
    IEx.Helpers.clear()
    IO.puts(Pane.Viewer.current_page().data)

    input = <<"\n", Pane.Viewer.prompt()::binary>> |> IO.gets()
    process(input)
  end

  defp process("f\n") do
    Pane.Viewer.first_page()
    recv_input()
  end

  defp process("l\n") do
    Pane.Viewer.last_page()
    recv_input()
  end

  defp process("j\n") do
    Pane.Viewer.next_page()
    recv_input()
  end

  defp process("k\n") do
    Pane.Viewer.prev_page()
    recv_input()
  end

  defp process("q\n") do
    Pane.Viewer.stop()
    IEx.Helpers.clear()
    :ok
  end

  defp process(_else) do
    Pane.Viewer.current_page()
    recv_input()
  end
end
