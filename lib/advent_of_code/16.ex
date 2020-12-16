defmodule AdventOfCode.Sixteen do
  def part_1() do
    File.read!("priv/16.txt")
    |> part_1()
  end

  def part_1(input) do
    input
    |> parse_props()
    |> scan(input)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def part_2() do
    input = File.read!("priv/16.txt")

    input
    |> parse_props()
    |> scan(input)
    |> Enum.reject(fn {sum, _} -> sum > 0 end)
    |> Enum.map(fn {_, ticket} -> ticket end)
    |> IO.inspect()
  end

  defp parse_props(ticket) do
    ticket
    |> String.split("\n")
    |> Enum.reduce_while(%{}, fn el, acc ->
      case el do
        "" ->
          {:halt, acc}

        line ->
          [_, prop] = Regex.run(~r/^(\w|\s)+:/, line)
          nums = get_nums(line)
          {:cont, Map.put(acc, prop, nums)}
      end
    end)
  end

  defp get_nums(line) do
    r = ~r/(\d+-\d+)/

    Regex.scan(r, line)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(fn rule ->
      nums = String.split(rule, "-")
      [start, stop] = Enum.map(nums, &String.to_integer/1)

      start..stop
    end)
  end

  defp scan(rules, input) do
    [_, nearby] = String.split(input, "nearby tickets:")

    valid =
      Map.values(rules)
      |> List.flatten()

    nearby
    |> String.split("\n", trim: true)
    |> Stream.map(fn line -> String.split(line, ",") |> Enum.map(&String.to_integer/1) end)
    |> Stream.map(fn ticket ->
      sum =
        Enum.filter(ticket, fn num -> !Enum.any?(valid, fn rule -> num in rule end) end)
        |> Enum.sum()

      {sum, ticket}
    end)
    |> Enum.to_list()
  end
end
