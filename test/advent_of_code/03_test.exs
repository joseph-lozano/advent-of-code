defmodule AdventOfCode.ThreeTest do
  use ExUnit.Case, async: true
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

    assert Three.part_2(input) == 336
  end
end
