defmodule AdventOfCode.ElevenTest do
  use ExUnit.Case, async: true
  alias AdventOfCode.Eleven

  test "part 1" do
    input = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    assert 37 == Eleven.part_1(input)
  end

  test "part 1 real" do
    assert 2324 == Eleven.part_1()
  end

  test "part 2" do
    input = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    assert 26 == Eleven.part_2(input)
  end

  test "part 2 real" do
    assert 2068 == Eleven.part_2()
  end
end
