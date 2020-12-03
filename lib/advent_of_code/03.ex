defmodule AdventOfCode.Three do
  def part_1() do
    "priv/03.part_1.txt"
    |> File.read!()
    |> part_1()
  end

  @movement {3, 1}

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
    {right, _down} = @movement

    for y_index <- 0..(grid_height - 1) do
      x_index = rem(right * y_index, grid_width)

      grid
      |> Enum.at(y_index)
      |> Enum.at(x_index)
    end
    |> Enum.count(fn x -> x == "#" end)
  end
end
