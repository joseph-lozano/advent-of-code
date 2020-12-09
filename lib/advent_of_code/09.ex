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

  def part_2() do
    "priv/09.txt"
    |> File.read!()
    |> String.trim()
    |> part_2()
  end

  def part_2(input, lookback \\ 25) do
    invalid_number = part_1(input, lookback)

    numbers = parse_input(input)
    input_size = Enum.count(numbers)

    Enum.reduce_while(0..(input_size - 1), 0, fn a, a_acc ->
      Enum.reduce_while((a + 1)..(input_size - 1), 0, fn b, b_acc ->
        slice =
          numbers
          |> Enum.slice(a..b)

        sum = Enum.sum(slice)

        cond do
          sum == invalid_number -> {:halt, Enum.min(slice) + Enum.max(slice)}
          sum > invalid_number -> {:halt, :gt}
          true -> {:cont, b_acc}
        end
      end)
      |> case do
        :gt -> {:cont, a_acc}
        value -> {:halt, value}
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
