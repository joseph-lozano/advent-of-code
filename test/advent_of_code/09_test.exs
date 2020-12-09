defmodule AdventOfCode.NineTest do
  use ExUnit.Case
  alias AdventOfCode.Nine

  test "part 1" do
    input =
      """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """
      |> String.trim()

    assert Nine.part_1(input, 5) == 127
  end

  test "part 1 real" do
    assert Nine.part_1() == 21_806_024
  end

  test "part 2" do
    input =
      """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """
      |> String.trim()

    assert Nine.part_2(input, 5) == 62
  end

  test "part 2 real" do
    assert Nine.part_2() == 2_986_195
  end
end
