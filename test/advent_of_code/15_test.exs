defmodule AdventOfCode.FifteenTest do
  use ExUnit.Case
  alias AdventOfCode.Fifteen

  @example "0,3,6"
  test "part 1" do
    assert 0 == Fifteen.part_1(@example, 1)
    assert 3 == Fifteen.part_1(@example, 2)
    assert 6 == Fifteen.part_1(@example, 3)
    assert 0 == Fifteen.part_1(@example, 4)
    assert 3 == Fifteen.part_1(@example, 5)
    assert 3 == Fifteen.part_1(@example, 6)
    assert 1 == Fifteen.part_1(@example, 7)
    assert 0 == Fifteen.part_1(@example, 8)
    assert 4 == Fifteen.part_1(@example, 9)
    assert 0 == Fifteen.part_1(@example, 10)
    assert 436 == Fifteen.part_1(@example, 2020)
  end

  test "more part 1" do
    assert Fifteen.part_1("1,3,2") == 1
    assert Fifteen.part_1("2,1,3") == 10
    assert Fifteen.part_1("1,2,3") == 27
    assert Fifteen.part_1("2,3,1") == 78
    assert Fifteen.part_1("3,2,1") == 438
    assert Fifteen.part_1("3,1,2") == 1836
  end

  test "part 1 real" do
    real_input = "10,16,6,0,1,17"
    assert 412 == Fifteen.part_1(real_input, 2020)
  end
end
