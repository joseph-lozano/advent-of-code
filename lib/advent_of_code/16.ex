defmodule AdventOfCode.Sixteen do
  def part_1() do
    File.read!("priv/16.txt")
    |> part_1()
  end

  def part_1(input) do
    input
    |> parse_props()
    |> scan(input)
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sum()
  end

  def part_2() do
    input = File.read!("priv/16.txt")

    rules =
      input
      |> parse_props()

    valid_tickets =
      scan(rules, input)
      |> Enum.reject(fn {sum, _} -> sum != [] end)
      |> Enum.map(fn {_, ticket} -> ticket end)

    length = length(hd(valid_tickets))

    possible_values =
      for i <- 1..length, into: %{} do
        {i, Map.keys(rules)}
      end

    field_map =
      Enum.reduce(valid_tickets, {rules, possible_values}, fn ticket, acc ->
        ticket
        |> Enum.with_index(1)
        |> Enum.reduce(acc, &check(&1, &2))
      end)
      |> elem(1)
      |> eliminate()

    my_ticket = parse_my_ticket(input)

    departure_indexes =
      Enum.filter(field_map, fn {key, _} -> String.starts_with?(key, "departure ") end)
      |> Enum.map(&elem(&1, 1))

    Enum.reduce(departure_indexes, 1, fn el, acc ->
      Enum.at(my_ticket, el - 1) * acc
    end)
  end

  defp eliminate(possiblities_map, eliminated \\ []) do
    if Enum.all?(possiblities_map, fn {_key, val} -> length(val) == 1 end) do
      for {i, [field]} <- possiblities_map, into: %{} do
        {field, i}
      end
    else
      do_eliminate(possiblities_map, eliminated)
    end
  end

  defp do_eliminate(possibilies_map, eliminated) do
    {safe_index, [field]} =
      Enum.find(possibilies_map, fn
        {_key, [val]} -> val not in eliminated
        {_, _} -> false
      end)

    new_map =
      for {index, fields} <- possibilies_map, into: %{} do
        if index == safe_index do
          {index, fields}
        else
          {index, List.delete(fields, field)}
        end
      end

    eliminate(new_map, [field | eliminated])
  end

  defp check({val, index}, {rules, acc}) do
    invalid_fields =
      Enum.reject(rules, fn {_key, ranges} ->
        Enum.any?(ranges, fn range -> val in range end)
      end)
      |> Enum.map(&elem(&1, 0))

    new_acc = Map.update!(acc, index, &(&1 -- invalid_fields))
    {rules, new_acc}
  end

  defp parse_props(ticket) do
    ticket
    |> String.split("\n")
    |> Enum.reduce_while(%{}, fn el, acc ->
      case el do
        "" ->
          {:halt, acc}

        line ->
          [prop] = Regex.run(~r/^[^:]+/, line)

          nums = get_nums(line)
          {:cont, Map.put(acc, prop, nums)}
      end
    end)
  end

  defp get_nums(line) do
    r = ~r/(\d+-\d+)/

    Regex.scan(r, line)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(fn rule ->
      nums = String.split(rule, "-")
      [start, stop] = Enum.map(nums, &String.to_integer/1)

      start..stop
    end)
  end

  defp scan(rules, input) do
    [_, nearby] = String.split(input, "nearby tickets:")

    valid =
      Map.values(rules)
      |> List.flatten()

    nearby
    |> String.split("\n", trim: true)
    |> Stream.map(fn line -> String.split(line, ",") |> Enum.map(&String.to_integer/1) end)
    |> Stream.map(fn ticket ->
      sum = Enum.filter(ticket, fn num -> !Enum.any?(valid, fn rule -> num in rule end) end)

      {sum, ticket}
    end)
    |> Enum.to_list()
  end

  defp parse_my_ticket(input) do
    split_ticket = String.split(input, "\n")
    my_ticket_index = Enum.find_index(split_ticket, &(&1 == "your ticket:")) + 1

    Enum.at(split_ticket, my_ticket_index)
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
