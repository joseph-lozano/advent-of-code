defmodule AdventOfCode.Eight do
  def part_1() do
    "priv/08.txt"
    |> File.read!()
    |> String.trim()
    |> part_1()
  end

  def part_1(input) do
    instructions = parse_instructions(input)

    {:loop_detected, val} = execute(instructions, 0, 0, [])
    val
  end

  def part_2() do
    "priv/08.txt"
    |> File.read!()
    |> String.trim()
    |> part_2()
  end

  def part_2(input) do
    instructions = parse_instructions(input)

    Enum.reduce_while(instructions, nil, fn el, acc ->
      {index, _instruction} = el
      new_instructions = alter_instruction(instructions, index)

      case execute(new_instructions, 0, 0, []) do
        {:loop_detected, _} -> {:cont, acc}
        {:done, val} -> {:halt, val}
      end
    end)
  end

  defp alter_instruction(instructions, index) do
    Map.update(instructions, index, nil, fn prev ->
      case prev do
        {"acc", _arg} -> prev
        {"jmp", arg} -> {"nop", arg}
        {"nop", arg} -> {"jmp", arg}
      end
    end)
  end

  defp execute(instructions, current, accumulator, history) do
    instruction = instructions[current]

    cond do
      current in history ->
        {:loop_detected, accumulator}

      current >= Enum.count(instructions) ->
        {:done, accumulator}

      true ->
        case instruction do
          {"nop", _} ->
            execute(instructions, current + 1, accumulator, [current | history])

          {"acc", amount} ->
            execute(instructions, current + 1, accumulator + String.to_integer(amount), [
              current | history
            ])

          {"jmp", amount} ->
            execute(instructions, current + String.to_integer(amount), accumulator, [
              current | history
            ])
        end
    end
  end

  defp to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {instruction, index} -> {index, instruction} end)
    |> Enum.into(%{})
  end

  defp parse_instructions(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> to_map
  end

  defp parse_instruction(line) do
    [command, argument] =
      line
      |> String.split(" ")

    {command, argument}
  end
end
