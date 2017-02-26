defmodule Pane do
  @moduledoc """
  Documentation for Pane.
  """

  def console(data) do
    Pane.Viewer.start_link(data: data)
    recv_input()
  end

  def recv_input do
    IEx.Helpers.clear
    IO.puts Pane.Viewer.current_page.data

    input = "\n" <> Pane.Viewer.prompt |> IO.gets
    process(input)
  end

  def process(input) do
    case input do
      "j\n" -> Pane.Viewer.next_page
      "k\n" -> Pane.Viewer.prev_page
      "q\n" -> :ok
    end

    if input != "q\n" do recv_input() else :ok end
  end
end
