defmodule AdventOfCode.OneTest do
  use ExUnit.Case
  alias AdventOfCode.One

  test "part 1" do
    input = """
    1721
    979
    366
    299
    675
    1456
    """

    expected = 514_579

    assert One.part_1(input) == expected
  end

  test "part 2" do
    input = """
    1721
    979
    366
    299
    675
    1456
    """

    expected = 241_861_950

    assert One.part_2(input) == expected
  end
end
