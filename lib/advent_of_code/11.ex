defmodule AdventOfCode.Eleven do
  def part_1() do
    "priv/11.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    grid =
      input
      |> String.split()
      |> Enum.map(&String.graphemes/1)

    transform(grid, nil, &neighbors/3, 4)
    |> List.flatten()
    |> Enum.count(&(&1 == "#"))
  end

  def part_2() do
    "priv/11.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    grid =
      input
      |> String.split()
      |> Enum.map(&String.graphemes/1)

    transform(grid, nil, &visible_neighbors/3, 5)
    |> List.flatten()
    |> Enum.count(&(&1 == "#"))
  end

  defp visible_neighbors(grid, x, y) do
    directions =
      for x_dir <- [-1, 0, 1], y_dir <- [-1, 0, 1] do
        unless x_dir == 0 and y_dir == 0, do: {x_dir, y_dir}
      end
      |> Enum.reject(&is_nil/1)

    start = {x, y}

    Enum.map(directions, fn dir -> check(grid, start, dir) end)
    |> Enum.reject(&is_nil/1)
  end

  defp check(grid, {x, y}, {x_dir, y_dir}) do
    {check_x, check_y} = {x + x_dir, y + y_dir}

    case at(grid, check_x, check_y) do
      "." -> check(grid, {check_x, check_y}, {x_dir, y_dir})
      seat -> seat
    end
  end

  defp transform(grid, prev, _, _) when grid == prev do
    grid
  end

  defp transform(grid, _prev, neighbors_fn, threshold) when is_list(grid) do
    width = grid |> hd() |> length()
    height = grid |> length()

    for y <- 0..(height - 1), x <- 0..(width - 1) do
      square = at(grid, x, y)
      neighbors = neighbors_fn.(grid, x, y)
      transform(square, neighbors, threshold)
    end
    |> Enum.chunk_every(width)
    |> transform(grid, neighbors_fn, threshold)
  end

  defp transform(".", _, _) do
    "."
  end

  defp transform("L", neighbors, _) do
    if Enum.any?(neighbors, &(&1 == "#")), do: "L", else: "#"
  end

  defp transform("#", neighbors, threshold) do
    if Enum.count(neighbors, &(&1 == "#")) >= threshold, do: "L", else: "#"
  end

  def neighbors(grid, x, y) do
    for x_diff <- [-1, 0, 1], y_diff <- [-1, 0, 1] do
      unless y_diff == 0 and x_diff == 0 do
        at(grid, x + x_diff, y + y_diff)
      end
    end
    |> Enum.reject(&is_nil/1)
  end

  defp at(grid, x, y) do
    grid
    |> at(y)
    |> at(x)
  end

  defp at(_enum, index) when index < 0 do
    nil
  end

  defp at(nil, _) do
    nil
  end

  defp at(_, nil) do
    nil
  end

  defp at(enum, index) do
    Enum.at(enum, index)
  end
end
