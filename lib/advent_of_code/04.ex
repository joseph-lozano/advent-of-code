defmodule AdventOfCode.Four do
  def part_1() do
    "priv/04.txt"
    |> File.read!()
    |> part_1()
  end

  def part_1(input) do
    passports = parse_input(input)
    Enum.count(passports, &valid_part_1?/1)
  end

  def part_2() do
    "priv/04.txt"
    |> File.read!()
    |> part_2()
  end

  def part_2(input) do
    passports = parse_input(input)
    Enum.count(passports, &valid_part_2?/1)
  end

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&parse_passport/1)
  end

  defp parse_passport(data) do
    data
    |> String.split(~r/\s/)
    |> Enum.reduce(%{}, fn el, acc ->
      [key, val] = String.split(el, ":")
      Map.put_new(acc, key, val)
    end)
  end

  @required_fields ~w(ecl pid eyr hcl byr iyr hgt)
  defp valid_part_1?(passport) do
    fields = Map.keys(passport)
    Enum.all?(@required_fields, fn f -> f in fields end)
  end

  def valid_part_2?(passport) do
    Enum.all?(@required_fields, fn f ->
      valid = f in Map.keys(passport) and valid_data?(passport[f], f)
      if valid, do: IO.puts("#{valid}: #{f} => #{passport[f]}")
      valid
    end)
  end

  def valid_data?(data, "ecl") do
    data in ~w(amb blu brn gry grn hzl oth)
  end

  def valid_data?(data, "pid") do
    Regex.match?(~r/^\d{9}$/, data)
  end

  def valid_data?(data, "eyr") do
    with {year, ""} <- Integer.parse(data, 10) do
      2020 <= year and year <= 2030
    else
      _ -> false
    end
  end

  def valid_data?(data, "hcl") do
    Regex.match?(~r/#[a-f0-9]{6}$/, data)
  end

  def valid_data?(data, "byr") do
    with {year, ""} <- Integer.parse(data, 10) do
      1920 <= year and year <= 2002
    else
      _ -> false
    end
  end

  def valid_data?(data, "iyr") do
    with {year, ""} <- Integer.parse(data, 10) do
      2010 <= year and year <= 2020
    else
      _ -> false
    end
  end

  def valid_data?(data, "hgt") do
    case Integer.parse(data) do
      {val, "cm"} -> 150 <= val and val <= 193
      {val, "in"} -> 59 <= val and val <= 76
      _ -> false
    end
  end
end
