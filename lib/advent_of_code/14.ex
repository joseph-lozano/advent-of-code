defmodule AdventOfCode.Fourteen do
  def part_1() do
    File.read!("priv/14.txt")
    |> part_1()
  end

  def part_1(input) do
    commands = parse(input)

    commands
    |> Enum.reduce(%{}, fn
      {:mask, mask}, acc ->
        Map.put(acc, :mask, mask)

      {:write, {address, value}}, acc ->
        to_write =
          Integer.to_string(value, 2)
          |> String.pad_leading(36, "0")
          |> String.graphemes()

        value =
          Enum.reduce(acc.mask, to_write, fn {index, value}, acc ->
            List.replace_at(acc, index, value)
          end)
          |> Enum.join()
          |> String.to_integer(2)

        Map.put(acc, address, value)
    end)
    |> Map.drop([:mask])
    |> Map.values()
    |> Enum.sum()
  end

  defp parse(input, part \\ :part_1) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line ->
      case String.slice(line, 0, 3) do
        "mas" -> {:mask, parse_mask(line, part)}
        "mem" -> {:write, parse_write(line)}
      end
    end)
  end

  defp parse_mask(mask, :part_2) do
    [_, mask] = String.split(mask, " = ", parts: 2)

    mask
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {el, index}, acc ->
      Map.put(acc, index, el)
    end)
  end

  defp parse_mask(mask, _part_1) do
    [_, mask] = String.split(mask, " = ", parts: 2)

    mask
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {el, index}, acc ->
      case el do
        "X" -> acc
        x -> Map.put(acc, index, x)
      end
    end)
  end

  defp parse_write(instruction) do
    regex = ~r/\[(\d+)]/

    address =
      regex
      |> Regex.run(instruction)
      |> List.last()
      |> String.to_integer()

    [_, value] = String.split(instruction, " = ")
    {address, String.to_integer(value)}
  end

  def part_2() do
    File.read!("priv/14.txt")
    |> part_2()
  end

  def part_2(input) do
    parse(input, :part_2)
    |> Enum.reduce(%{}, fn
      {:mask, mask}, acc ->
        Map.put(acc, :mask, mask)

      {:write, {address, value}}, acc ->
        writes =
          address
          |> Integer.to_string(2)
          |> String.pad_leading(36, "0")
          |> apply_mask(acc.mask)
          |> List.flatten()
          |> Enum.uniq()
          |> Enum.map(fn address -> {String.to_integer(address, 2), value} end)
          |> Enum.into(%{})

        Map.merge(acc, writes)
    end)
    |> Map.drop([:mask])
    |> Map.values()
    |> Enum.sum()
  end

  defp apply_mask(binary, mask) do
    Enum.reduce(mask, String.graphemes(binary), fn
      {_index, "0"}, acc -> acc
      {index, x}, acc -> List.replace_at(acc, index, x)
    end)
    |> apply_floating
  end

  defp apply_floating(mask) do
    if Enum.all?(mask, &(&1 != "X")) do
      Enum.join(mask)
    else
      mask
      |> Enum.with_index()
      |> Enum.reduce_while([], fn
        {"X", index}, acc ->
          one = apply_floating(List.replace_at(mask, index, "1"))
          zero = apply_floating(List.replace_at(mask, index, "0"))

          {:halt, [one | [zero | acc]]}

        _, acc ->
          {:cont, acc}
      end)
    end
  end
end
