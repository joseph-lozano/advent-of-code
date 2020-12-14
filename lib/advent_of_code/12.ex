defmodule AdventOfCode.Twelve do
  def part_1() do
    File.read!("priv/12.txt")
    |> part_1()
  end

  def part_1(input) do
    input
    |> read_instructions()
    |> Enum.reduce({0, 0, "E"}, fn instruction, {x, y, dir} ->
      case instruction do
        {"N", distance} -> {x, y + distance, dir}
        {"S", distance} -> {x, y - distance, dir}
        {"E", distance} -> {x + distance, y, dir}
        {"W", distance} -> {x - distance, y, dir}
        {"L", degrees} -> turn("L", degrees, x, y, dir)
        {"R", degrees} -> turn("R", degrees, x, y, dir)
        {"F", distance} -> move(distance, x, y, dir)
      end
    end)
    |> manhattan_distance()
  end

  def part_2() do
    File.read!("priv/12.txt")
    |> part_2()
  end

  def part_2(input, waypoint_start \\ {10, 1}) do
    input
    |> read_instructions()
    |> Enum.reduce({{0, 0}, waypoint_start}, fn instruction,
                                                {ship_acc, {wx, wy} = waypoint_acc} ->
      case instruction do
        {"N", distance} -> {ship_acc, {wx, wy + distance}}
        {"S", distance} -> {ship_acc, {wx, wy - distance}}
        {"E", distance} -> {ship_acc, {wx + distance, wy}}
        {"W", distance} -> {ship_acc, {wx - distance, wy}}
        {"L", degrees} -> rotate("L", ship_acc, waypoint_acc, div(degrees, 90))
        {"R", degrees} -> rotate("R", ship_acc, waypoint_acc, div(degrees, 90))
        {"F", times} -> move_to_waypoint(ship_acc, waypoint_acc, times)
      end
    end)
    |> manhattan_distance()
  end

  defp rotate(_, ship, waypoint, 0), do: {ship, waypoint}

  defp rotate("R", ship, {wx, wy}, times) do
    rotate("R", ship, {wy, wx * -1}, times - 1)
  end

  defp rotate("L", ship, {wx, wy}, times) do
    rotate("L", ship, {wy * -1, wx}, times - 1)
  end

  defp move_to_waypoint(ship, waypoint, 0) do
    {ship, waypoint}
  end

  defp move_to_waypoint({sx, sy}, {wx, wy} = waypoint, times) do
    move_to_waypoint({sx + wx, sy + wy}, waypoint, times - 1)
  end

  def sin(90), do: 1
  def sin(-90), do: -1
  def cos(0), do: 1
  def cos(90), do: 0
  def cos(-90), do: 0

  defp manhattan_distance({{x, y}, _}) do
    abs(x) + abs(y)
  end

  defp manhattan_distance({x, y, _}) do
    abs(x) + abs(y)
  end

  defp move(distance, x, y, "N" = dir), do: {x, y + distance, dir}
  defp move(distance, x, y, "S" = dir), do: {x, y - distance, dir}
  defp move(distance, x, y, "E" = dir), do: {x + distance, y, dir}
  defp move(distance, x, y, "W" = dir), do: {x - distance, y, dir}

  defp turn(left_or_right, degrees, x, y, dir) when is_binary(dir) do
    times = div(degrees, 90)
    turn(left_or_right, x, y, dir, times)
  end

  defp turn(_, x, y, dir, 0), do: {x, y, dir}

  defp turn("L", x, y, "N", times), do: turn("L", x, y, "W", times - 1)
  defp turn("L", x, y, "S", times), do: turn("L", x, y, "E", times - 1)
  defp turn("L", x, y, "E", times), do: turn("L", x, y, "N", times - 1)
  defp turn("L", x, y, "W", times), do: turn("L", x, y, "S", times - 1)
  defp turn("R", x, y, "N", times), do: turn("R", x, y, "E", times - 1)
  defp turn("R", x, y, "S", times), do: turn("R", x, y, "W", times - 1)
  defp turn("R", x, y, "E", times), do: turn("R", x, y, "S", times - 1)
  defp turn("R", x, y, "W", times), do: turn("R", x, y, "N", times - 1)

  defp read_instructions(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", parts: 2, trim: true))
    |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
  end
end
