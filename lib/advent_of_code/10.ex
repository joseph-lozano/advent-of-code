defmodule AdventOfCode.Ten do
  def part_1() do
    "priv/10.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    numbers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    differences = adapter_differences(numbers, 0, %{1 => 0, 2 => 0, 3 => 0})
    differences[1] * differences[3]
  end

  def part_2() do
    "priv/10.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    g = Graph.new()

    numbers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    last = List.last(numbers)

    g = adapter_arrangements([0 | numbers], g)

    {count, _} = get_paths_count(g, 0, last)
    count
  end

  defp adapter_arrangements(numbers, g) do
    Enum.reduce(numbers, g, fn num, g ->
      edges =
        for n <- [num], next <- Enum.filter(numbers, &(num < &1 && &1 <= num + 3)) do
          Graph.Edge.new(n, next)
        end

      Graph.add_edges(g, edges)
    end)
  end

  def get_paths_count(g, from, to) do
    get_paths_count(g, from, to, %{})
  end

  defp get_paths_count(_g, from, to, memo) when from == to do
    {1, memo}
  end

  defp get_paths_count(g, from, to, memo) do
    case Map.get(memo, from) do
      found when not is_nil(found) ->
        {found, memo}

      nil ->
        Graph.out_edges(g, from)
        |> Enum.reduce({0, memo}, fn %{v2: next}, {acc_count, memo} ->
          {count, memo} = get_paths_count(g, next, to, memo)
          {count + acc_count, Map.put(memo, next, count)}
        end)
    end
  end

  def adapter_differences([], _prev, differences) do
    update_in(differences, [3], &(&1 + 1))
  end

  def adapter_differences([current | rest], prev, differences) do
    difference = current - prev
    adapter_differences(rest, current, update_in(differences, [difference], &(&1 + 1)))
  end
end
