defmodule AdventOfCode.Five do
  def part_1() do
    "priv/05.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(0, fn el, acc ->
      id = part_1(el)
      if id > acc, do: id, else: acc
    end)
  end

  def part_1(input) do
    {row, column} =
      input
      |> String.graphemes()
      |> Enum.map(&to_binary/1)
      |> Enum.split(7)

    {row, ""} = row |> Enum.join() |> Integer.parse(2)
    {column, ""} = column |> Enum.join() |> Integer.parse(2)

    row * 8 + column
  end

  def part_2() do
    passes =
      "priv/05.txt"
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn el -> part_1(el) end)
      |> Enum.sort()

    range =
      List.first(passes)..List.last(passes)
      |> MapSet.new()

    pass_set = MapSet.new(passes)

    [pass] =
      MapSet.difference(range, pass_set)
      |> MapSet.to_list()

    pass
  end

  defp to_binary("B"), do: "1"
  defp to_binary("F"), do: "0"
  defp to_binary("R"), do: "1"
  defp to_binary("L"), do: "0"
end
