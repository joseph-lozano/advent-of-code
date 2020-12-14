defmodule AdventOfCode.TwelveTest do
  use ExUnit.Case
  alias AdventOfCode.Twelve

  @example """
  F10
  N3
  F7
  R90
  F11
  """

  test "part 1" do
    assert 25 == Twelve.part_1(@example)
  end

  test "part 1 real" do
    assert 1319 <
             Twelve.part_1()
  end

  test "part 2" do
    assert 286 == Twelve.part_2(@example)
  end

  test "part 2 real" do
    assert 178_986 == Twelve.part_2()
  end
end
