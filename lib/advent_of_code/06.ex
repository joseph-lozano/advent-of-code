defmodule AdventOfCode.Six do
  def part_1() do
    "priv/06.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&part_1/1)
    |> Enum.sum()
  end

  def part_1(input) do
    input
    |> String.graphemes()
    |> Enum.reject(fn g -> g == "\n" end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def part_2() do
    "priv/06.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&part_2/1)
    |> Enum.sum()
  end

  def part_2(input) do
    [first_person_answers | rest] =
      String.trim(input)
      |> String.split("\n")

    for answer <- String.graphemes(first_person_answers) do
      Enum.all?(rest, fn answers -> String.contains?(answers, answer) end)
    end
    |> Enum.count(fn bool -> !!bool end)
  end
end
