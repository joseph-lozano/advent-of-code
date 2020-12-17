defmodule AdventOfCode.EightTest do
  use ExUnit.Case, async: true
  alias AdventOfCode.Eight

  test "part 1" do
    input =
      """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """
      |> String.trim()

    assert Eight.part_1(input) == 5
  end

  test "part 1 real" do
    assert Eight.part_1() == 1614
  end

  test "part 2" do
    input =
      """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """
      |> String.trim()

    assert Eight.part_2(input) == 8
  end

  test "part 2 real" do
    assert Eight.part_2() == 1260
  end
end
