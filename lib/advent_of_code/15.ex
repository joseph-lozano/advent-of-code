defmodule AdventOfCode.Fifteen do
  def part_1() do
    File.read!("priv/15.txt")
    |> part_1()
  end

  def part_1(input, to_find \\ 2020) do
    input
    |> parse()
    |> play(to_find)
  end

  def play(nums, until) do
    if until <= length(nums) do
      Enum.at(nums, until - 1)
    else
      do_play(nums, until)
      |> elem(1)
      |> elem(0)
    end
  end

  defp do_play(nums, until) do
    nums = nums |> Enum.with_index() |> Enum.reverse()

    map =
      nums
      |> Enum.map(fn {num, index} -> {num, {index}} end)
      |> Enum.into(%{})

    Enum.reduce(length(nums)..(until - 1), {map, hd(nums)}, fn
      el, {map, {last_num, last_index}} ->
        distance =
          case Map.get(map, last_num) do
            {last_time} -> last_index - last_time
            {last_time, prev_time} -> last_time - prev_time
          end

        new_map =
          Map.update(map, distance, {el}, fn
            {old} -> {el, old}
            {old, _prev} -> {el, old}
          end)

        {new_map, {distance, el}}
    end)
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
