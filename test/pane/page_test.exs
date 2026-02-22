defmodule Pane.PageTest do
  use ExUnit.Case
  doctest Pane.Page

  alias Pane.Page

  describe "paginate/2" do
    test "empty string returns single page" do
      [page] = Page.paginate("")
      assert page.data == ""
      assert page.index == 0
    end

    test "data within max_lines returns single page" do
      data = Enum.join(1..5, "\n")
      [page] = Page.paginate(data, 10)
      assert page.data == data
      assert page.index == 0
    end

    test "data exceeding max_lines returns multiple pages" do
      data = Enum.join(1..10, "\n")
      pages = Page.paginate(data, 3)
      assert length(pages) == 4
      assert Enum.map(pages, & &1.index) == [0, 1, 2, 3]
    end

    test "data at exact max_lines boundary returns single page" do
      data = Enum.join(1..5, "\n")
      [page] = Page.paginate(data, 5)
      assert page.data == data
      assert page.index == 0
    end

    test "data one over max_lines boundary returns two pages" do
      data = Enum.join(1..6, "\n")
      pages = Page.paginate(data, 5)
      assert length(pages) == 2
      assert List.first(pages).data == Enum.join(1..5, "\n")
      assert List.last(pages).data == "6"
    end

    test "pages contain correct data splits" do
      data = Enum.join(1..6, "\n")
      [p1, p2] = Page.paginate(data, 3)
      assert p1.data == "1\n2\n3"
      assert p2.data == "4\n5\n6"
    end
  end
end
