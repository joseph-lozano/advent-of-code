defmodule AdventOfCode.Seven do
  def part_1() do
    "priv/07.txt"
    |> File.read!()
    |> String.trim()
    |> part_1()
    |> Enum.count()
  end

  def part_1(input) do
    rules = get_rules(input)

    find_bag("shiny gold bag", rules, [])
    |> Enum.reject(fn found_bag -> found_bag == "shiny gold bag" end)
  end

  defp find_bag(bag, rules, found) do
    parents = Enum.filter(rules, fn rule -> has_parent?(bag, rule) end)

    if Enum.empty?(parents) do
      [bag | found]
    else
      parent_bags = Enum.map(parents, fn {bag, _} -> bag end)

      Enum.flat_map(parent_bags, fn parent_bag -> find_bag(parent_bag, rules, [bag | found]) end)
    end
    |> Enum.uniq()
  end

  defp get_rules(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn rule ->
      [container, containees] = String.split(rule, "contain")
      container = String.trim(container) |> String.replace(~r/s$/, "")

      containees =
        String.split(containees, ",")
        |> Enum.map(fn c ->
          c
          |> String.replace(".", "")
          |> String.trim()
          |> String.replace(~r/s$/, "")
          |> parse_count()
        end)

      {container, containees}
    end)
  end

  def has_parent?(bag, rule) do
    {_parent, children} = rule

    Enum.any?(children, fn {_count, child} ->
      child == bag
    end)
  end

  defp parse_count(input) do
    case Integer.parse(input, 10) do
      :error -> {0, nil}
      {count, bag} -> {count, String.trim(bag)}
    end
  end

  def part_2() do
    "priv/07.txt"
    |> File.read!()
    |> String.trim()
    |> part_2()
  end

  def part_2(input) do
    rules = get_rules(input)
    get_count("shiny gold bag", rules, 0)
  end

  defp get_count(bag, rules, count) do
    {^bag, children} = Enum.find(rules, fn {rule, _} -> rule == bag end)
    count_children(children, rules, count)
  end

  defp count_children([], _rules, count) do
    count
  end

  defp count_children(children, rules, count) do
    Enum.reduce(children, count, fn child, acc ->
      {child_count, bag} = child

      case bag do
        nil -> 0
        bag -> child_count * get_count(bag, rules, 1)
      end + acc
    end)
  end
end
