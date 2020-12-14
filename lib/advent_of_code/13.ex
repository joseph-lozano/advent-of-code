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

  def part_2() do
    File.read!("priv/13.txt")
    |> part_2()
  end

  def part_2(input) do
    ids = parse_ids(input)

    check_time(ids, 0)
  end

  defp check_time(ids, time) do
    Enum.with_index(ids)
    |> Enum.map(fn {id, index} -> rem(time + index, id) end)
    |> all?(ids)
    |> case do
      num when is_integer(num) -> check_time(ids, time + num)
      :done -> time
    end
  end

  defp all?(enum, ids) do
    if Enum.all?(enum, &(&1 == 0)) do
      :done
    else
      idxs =
        enum
        |> Enum.reduce_while(0, fn el, acc ->
          if el == 0 do
            {:cont, acc + 1}
          else
            {:halt, acc}
          end
        end)

      ids
      |> Enum.take(idxs)
      |> Enum.reduce(1, &(&1 * &2))
    end
  end

  defp get_arrival_time(id, time, stop) do
    if time > stop, do: time, else: get_arrival_time(id, id + time, stop)
  end

  defp parse_ids(input) do
    [_start_time, ids] = String.split(input, "\n", trim: true, parts: 2)

    ids
    |> String.split(",")
    |> Enum.map(fn id ->
      case Integer.parse(id) do
        {id, ""} -> id
        :error -> 1
      end
    end)
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
