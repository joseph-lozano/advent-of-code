defmodule AdventOfCode do
  alias AdventOfCode.{One, Two, Three}

  def run(day, part) do
    day_mod =
      case day do
        1 -> One
        2 -> Two
        3 -> Three
      end

    case part do
      1 -> day_mod.part_1
      2 -> day_mod.part_2
    end
  end
end
