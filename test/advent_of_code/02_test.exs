defmodule AdventOfCode.TwoTest do
  use ExUnit.Case, async: true
  alias AdventOfCode.Two

  test "part 1" do
    input = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    expected = 2

    assert Two.part_1(input) == expected
  end

  test "part 2" do
    input = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    assert Two.part_2(input) == 1
  end
end
