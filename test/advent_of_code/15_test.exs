defmodule AdventOfCode.FifteenTest do
  use ExUnit.Case
  alias AdventOfCode.Fifteen

  @example "0,3,6"
  describe "part 1" do
    test "examples" do
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

    test "more examples" do
      assert Fifteen.part_1("1,3,2") == 1
      assert Fifteen.part_1("2,1,3") == 10
      assert Fifteen.part_1("1,2,3") == 27
      assert Fifteen.part_1("2,3,1") == 78
      assert Fifteen.part_1("3,2,1") == 438
      assert Fifteen.part_1("3,1,2") == 1836
    end

    test "real" do
      real_input = "10,16,6,0,1,17"
      assert 412 == Fifteen.part_1(real_input, 2020)
    end
  end

  describe "part 2" do
    for {input, expected} <- [
          {"0,3,6", 175_594},
          {"1,3,2", 2578},
          {"2,1,3", 3_544_142},
          {"1,2,3", 261_214},
          {"2,3,1", 6_895_259},
          {"3,2,1", 18},
          {"3,1,2", 362}
        ] do
      @tag timeout: 120_000
      @tag :long
      test "part 2 with input \"#{input}\"" do
        assert unquote(expected) == Fifteen.part_1(unquote(input), 30_000_000)
      end
    end

    @tag :long
    test "real" do
      assert 243 == Fifteen.part_1("10,16,6,0,1,17", 30_000_000)
    end
  end
end
