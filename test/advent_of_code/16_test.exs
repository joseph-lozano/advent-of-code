defmodule AdventOfCode.SixteenTest do
  use ExUnit.Case, async: true
  alias AdventOfCode.Sixteen

  describe "part 1" do
    @example """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """
    test "example" do
      assert 71 == Sixteen.part_1(@example)
    end

    test "real" do
      assert 27898 == Sixteen.part_1()
    end
  end

  describe "part 2" do
    test "real" do
      assert 2_766_491_048_287 == Sixteen.part_2()
    end
  end
end
