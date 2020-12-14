defmodule AdventOfCode.Thirteen do
  def part_1() do
    File.read!("priv/13.txt")
    |> part_1()
  end

  def part_1(input) do
    {start_time, ids} = parse(input)

    {id, arrival_time} =
      Enum.map(ids, fn id -> {id, get_arrival_time(id, 0, start_time)} end)
      |> Enum.min_by(fn {_id, time} -> time end)

    id * (arrival_time - start_time)
  end

  defp get_arrival_time(id, time, stop) do
    if time > stop, do: time, else: get_arrival_time(id, id + time, stop)
  end

  defp parse(input) do
    [start_time, ids] = String.split(input, "\n", trim: true)

    ids =
      String.split(ids, ",", trim: true)
      |> Enum.reject(&(&1 == "x"))
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(start_time), ids}
  end
end
