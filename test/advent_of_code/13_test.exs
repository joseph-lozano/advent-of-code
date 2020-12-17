defmodule AdventOfCode.ThirteenTest do
  use ExUnit.Case, async: true
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

  test "part 2" do
    cases = [
      {"7,13,x,x,59,x,31,19", 1_068_781},
      {"17,x,13,19", 3417},
      {"67,7,59,61", 754_018},
      {"67,x,7,59,61", 779_210},
      {"67,7,x,59,61", 1_261_476},
      {"1789,37,47,1889", 1_202_161_486}
    ]

    Enum.each(cases, fn {kase, expected} ->
      input = "foo\n" <> kase
      assert expected == Thirteen.part_2(input)
    end)
  end

  test "part 2 real" do
    assert 560_214_575_859_998 = Thirteen.part_2()
  end
end
