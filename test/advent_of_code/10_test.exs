defmodule AdventOfCode.TenTest do
  use ExUnit.Case
  alias AdventOfCode.Ten

  @input_a """
  16
  10
  15
  5
  1
  11
  7
  19
  6
  12
  4
  """

  test "part 1 a" do
    assert 35 == Ten.part_1(@input_a)
  end

  @input_b """
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  """

  test "part 1 b" do
    assert 220 == Ten.part_1(@input_b)
  end

  test "part 1 real" do
    assert 1755 == Ten.part_1()
  end

  test "part 2 a" do
    assert 8 == Ten.part_2(@input_a)
  end

  test "part 2 b" do
    assert 19208 == Ten.part_2(@input_b)
  end

  test "part 2 real" do
    assert 4_049_565_169_664 == Ten.part_2()
  end
end
