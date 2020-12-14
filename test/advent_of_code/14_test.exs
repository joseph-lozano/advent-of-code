defmodule AdventOfCode.FourteenTest do
  use ExUnit.Case
  alias AdventOfCode.Fourteen

  @example """
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
  """
  test "part 1" do
    assert 165 == Fourteen.part_1(@example)
  end

  test "part 1 real" do
    assert 13_556_564_111_697 == Fourteen.part_1()
  end

  test "part 2" do
    input = """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """

    assert 208 == Fourteen.part_2(input)
  end

  test "part 2 real" do
    assert 4_173_715_962_894 == Fourteen.part_2()
  end
end
