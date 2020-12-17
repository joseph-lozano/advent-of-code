defmodule AdventOfCode.FiveTest do
  use ExUnit.Case, async: true
  alias AdventOfCode.Five

  test "part 1" do
    input_a = "BFFFBBFRRR"
    input_b = "FFFBBBFRRR"
    input_c = "BBFFBBFRLL"

    assert Five.part_1(input_a) == 567
    assert Five.part_1(input_b) == 119
    assert Five.part_1(input_c) == 820
  end

  test "part 1 real" do
    assert Five.part_1() == 928
  end

  test "part 2 real" do
    assert Five.part_2() == 610
  end
end
