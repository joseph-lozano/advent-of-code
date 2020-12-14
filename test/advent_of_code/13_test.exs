defmodule AdventOfCode.ThirteenTest do
  use ExUnit.Case
  alias AdventOfCode.Thirteen

  @example """
  939
  7,13,x,x,59,x,31,19
  """

  test "part 1" do
    assert 295 == Thirteen.part_1(@example)
  end

  test "part 1 real" do
    assert 2238 == Thirteen.part_1()
  end
end
