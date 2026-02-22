defmodule Pane.ViewerTest do
  use ExUnit.Case
  doctest Pane.Viewer, import: true

  alias Pane.{Page, Viewer}

  defp build_state(num_pages, index \\ 0) do
    pages = Enum.map(0..(num_pages - 1), &Page.new("page #{&1}", &1))

    %Viewer{
      pages: pages,
      total_pages: num_pages,
      index: index
    }
  end

  describe "current_page/1" do
    test "returns page at current index" do
      state = build_state(3, 1)
      page = Viewer.current_page(state)
      assert page.data == "page 1"
      assert page.index == 1
    end

    test "returns first page when index is 0" do
      state = build_state(3)
      page = Viewer.current_page(state)
      assert page.data == "page 0"
    end
  end

  describe "inc_page/1" do
    test "increments index" do
      state = build_state(3, 0)
      assert Viewer.inc_page(state).index == 1
    end

    test "does not increment past last page" do
      state = build_state(3, 2)
      assert Viewer.inc_page(state).index == 2
    end

    test "does not increment on single page" do
      state = build_state(1, 0)
      assert Viewer.inc_page(state).index == 0
    end
  end

  describe "dec_page/1" do
    test "decrements index" do
      state = build_state(3, 2)
      assert Viewer.dec_page(state).index == 1
    end

    test "does not decrement below 0" do
      state = build_state(3, 0)
      assert Viewer.dec_page(state).index == 0
    end
  end

  describe "last_page_index/1" do
    test "returns last index" do
      assert Viewer.last_page_index(build_state(5)) == 4
    end

    test "returns 0 for single page" do
      assert Viewer.last_page_index(build_state(1)) == 0
    end
  end

  describe "page_description/1" do
    test "formats current position" do
      state = build_state(5, 2)
      assert Viewer.page_description(state) == "3 of 5"
    end

    test "formats first page" do
      state = build_state(3, 0)
      assert Viewer.page_description(state) == "1 of 3"
    end

    test "formats last page" do
      state = build_state(3, 2)
      assert Viewer.page_description(state) == "3 of 3"
    end
  end

  describe "prompt/1" do
    test "includes page description and commands" do
      state = build_state(3, 1)
      prompt = Viewer.prompt(state)
      assert prompt == "[2 of 3] (j)next (k)prev (f)first (l)last (q)quit "
    end
  end
end
