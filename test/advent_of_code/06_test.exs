defmodule AdventOfCode.SixTest do
  use ExUnit.Case
  alias AdventOfCode.Six

  test "part 1" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert input
           |> String.split("\n\n")
           |> Enum.map(&Six.part_1/1)
           |> Enum.sum() ==
             11
  end

  test "part 1 real" do
    assert Six.part_1() == 6587
  end

  test "part 2" do
    input = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert input
           |> String.split("\n\n")
           |> Enum.map(&Six.part_2/1)
           |> Enum.sum() ==
             6
  end

  test "part 2 real" do
    assert Six.part_2() == 3235
  end
end
