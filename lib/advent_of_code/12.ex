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
        {"F", distance} -> move(distance, x, y, dir)
        {"L", degrees} -> turn("L", degrees, x, y, dir)
        {"R", degrees} -> turn("R", degrees, x, y, dir)
      end
      |> IO.inspect(label: "#{inspect(instruction)} -> ")
    end)
    |> manhattan_distance()
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
    IO.inspect({left_or_right, degrees, times}, label: "turn")
    turn(left_or_right, x, y, dir, times)
  end

  defp turn(_, x, y, dir, 0), do: {x, y, dir}

  defp turn("L", x, y, "N", times), do: turn("L", x, y, "W", times - 1)
  defp turn("L", x, y, "S", times), do: turn("L", x, y, "E", times - 1)
  defp turn("L", x, y, "E", times), do: turn("L", x, y, "N", times - 1)
  defp turn("L", x, y, "W", times), do: turn("L", x, y, "S", times - 1)
  defp turn("R", x, y, "N", times), do: turn("L", x, y, "E", times - 1)
  defp turn("R", x, y, "S", times), do: turn("L", x, y, "W", times - 1)
  defp turn("R", x, y, "E", times), do: turn("L", x, y, "S", times - 1)
  defp turn("R", x, y, "W", times), do: turn("L", x, y, "N", times - 1)

  defp read_instructions(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", parts: 2, trim: true))
    |> Enum.map(fn [a, b] -> {a, String.to_integer(b)} end)
  end
end
