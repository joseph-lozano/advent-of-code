defmodule AdventOfCode.Nine do
  def part_1() do
    "priv/09.txt"
    |> File.read!()
    |> String.trim()
    |> part_1()
  end

  def part_1(input, lookback \\ 25) do
    numbers = parse_input(input)
    {preamble, rest} = Enum.split(numbers, lookback)

    Enum.reduce_while(rest, preamble, fn el, [_ | next] = acc ->
      if is_sum?(el, acc) do
        {:cont, next ++ [el]}
      else
        {:halt, el}
      end
    end)
  end

  defp is_sum?(number, numbers) do
    for a <- numbers, b <- numbers do
      a + b == number
    end
    |> Enum.any?()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
