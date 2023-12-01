defmodule Aoc2023.Day01Test do
  use ExUnit.Case
  alias Aoc2023.Day01

  test "part 1 solver" do
    assert 142 == Day01.solve_part_1("lib/aoc2023/day01/test_part_1.txt")
  end

  test "part 2 solver" do
    assert 281 == Day01.solve_part_2("lib/aoc2023/day01/test_part_2.txt")
  end
end
