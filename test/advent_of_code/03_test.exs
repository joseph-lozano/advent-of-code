defmodule AdventOfCode.ThreeTest do
  use ExUnit.Case
  alias AdventOfCode.Three

  test "part 1" do
    input = """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """

    expected = 7

    assert Three.part_1(input) == expected
  end

  test "part 2" do
  end
end
