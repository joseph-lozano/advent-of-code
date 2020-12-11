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
      |> to_map()

    transform(grid, nil, &neighbors/3, 4)
    |> Enum.count(fn {_key, val} -> val == "#" end)
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
      |> to_map()

    transform(grid, nil, &visible_neighbors/3, 5)
    |> Enum.count(fn {_key, val} -> val == "#" end)
  end

  defp to_map(grid) do
    grid
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, row_acc ->
      Map.merge(
        row_acc,
        row
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {square, x}, acc ->
          Map.put(acc, {x, y}, square)
        end)
      )
    end)
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

  defp transform(grid, _prev, neighbors_fn, threshold) when is_map(grid) do
    squares = Map.keys(grid)
    {width, _} = Enum.max_by(squares, fn {x, _y} -> x end)
    {_, height} = Enum.max_by(squares, fn {_x, y} -> y end)

    for y <- 0..height, x <- 0..width do
      square = at(grid, x, y)
      neighbors = neighbors_fn.(grid, x, y)
      transform(square, neighbors, threshold)
    end
    |> Enum.chunk_every(width + 1)
    |> to_map()
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
    Map.get(grid, {x, y})
  end
end
