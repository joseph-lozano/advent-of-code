defmodule AdventOfCode do
  alias AdventOfCode.{One, Two}

  def run(day, part) do
    day_mod =
      case day do
        1 -> One
        2 -> Two
      end

    case part do
      1 -> day_mod.part_1
      2 -> day_mod.part_2
    end
  end
end
