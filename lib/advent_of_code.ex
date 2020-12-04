defmodule AdventOfCode do
  alias AdventOfCode.{One, Two, Three, Four}

  def run(day, part) do
    day_mod =
      case day do
        1 -> One
        2 -> Two
        3 -> Three
        4 -> Four
      end

    case part do
      1 -> day_mod.part_1
      2 -> day_mod.part_2
    end
  end
end
