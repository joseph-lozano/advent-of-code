defmodule AdventOfCode.Two do
  def part_1() do
    "priv/02.part_1.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      {password, char, min_times, max_times} = parse_input(line)
      check_password_1(password, char, min_times, max_times)
    end)
    |> Enum.count(fn valid? -> !!valid? end)
  end

  def part_2() do
    "priv/02.part_1.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      {password, char, min_times, max_times} = parse_input(line)
      check_password_2(password, char, min_times, max_times)
    end)
    |> Enum.count(fn valid? -> !!valid? end)
  end

  def parse_input(line) do
    [times, char, password] =
      line
      |> String.split(" ")

    [a, b] = String.split(times, "-") |> Enum.map(&String.to_integer/1)
    char = String.replace(char, ":", "")
    {password, char, a, b}
  end

  defp check_password_1(password, char, min_times, max_times) do
    times = password |> String.graphemes() |> Enum.count(&(&1 == char))
    times >= min_times and times <= max_times
  end

  defp check_password_2(password, char, a, b) do
    chars = String.graphemes(password)
    at_a? = Enum.at(chars, a - 1) == char
    at_b? = Enum.at(chars, b - 1) == char

    case {at_a?, at_b?} do
      {true, true} -> false
      {false, false} -> false
      _ -> true
    end
  end
end
