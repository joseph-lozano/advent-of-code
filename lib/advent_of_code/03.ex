defmodule AdventOfCode.Three do
  def part_1() do
    "priv/03.part_1.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    grid =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line ->
        String.graphemes(line)
      end)

    grid_width = grid |> List.first() |> Enum.count()
    grid_height = grid |> Enum.count()
    # Stream.repeatedly(fn -> String.graphemes(line) end)
    {right, _down} = {3, 1}

    for y_index <- 0..(grid_height - 1) do
      x_index = rem(right * y_index, grid_width)

      grid
      |> Enum.at(y_index)
      |> Enum.at(x_index)
    end
    |> Enum.count(fn x -> x == "#" end)
  end

  def part_2() do
    "priv/03.part_1.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    grid =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line ->
        String.graphemes(line)
      end)

    grid_width = grid |> List.first() |> Enum.count()
    grid_height = grid |> Enum.count()
    # Stream.repeatedly(fn -> String.graphemes(line) end)

    tests = [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]

    for {right, down} <- tests do
      for step <- 0..(grid_height - 1) do
        y_index = step * down
        x_index = rem(right * step, grid_width)

        cond do
          y_index < grid_height ->
            grid
            |> Enum.at(y_index)
            |> Enum.at(x_index)

          true ->
            "."
        end
      end
      |> Enum.count(fn x -> x == "#" end)
    end
    |> Enum.reduce(1, fn el, acc -> el * acc end)
  end
end
