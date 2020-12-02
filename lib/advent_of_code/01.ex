defmodule AdventOfCode.One do
  def part_1() do
    "priv/01.part_1.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    nums = get_nums(input)

    {a, b} =
      Stream.flat_map(nums, fn i ->
        Stream.flat_map(nums, fn j ->
          [{i, j}]
        end)
      end)
      |> Enum.find(fn {i, j} -> i + j == 2020 end)

    a * b
  end

  def part_2() do
    "priv/one.part_1.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    nums = get_nums(input)

    {a, b, c} =
      Stream.flat_map(nums, fn i ->
        Stream.flat_map(nums, fn j ->
          Stream.flat_map(nums, fn k ->
            [{i, j, k}]
          end)
        end)
      end)
      |> Enum.find(fn {i, j, k} -> i + j + k == 2020 end)

    a * b * c
  end

  defp get_nums(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
