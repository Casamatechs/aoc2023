defmodule Aoc2023.Day02Test do
  use ExUnit.Case
  alias Aoc2023.Day02

  @test_file_path "lib/aoc2023/day02/test.txt"

  test "part 1 solver" do
    assert 8 == Day02.solve_part_1(@test_file_path)
  end

  test "part 2 solver" do
    assert 2286 == Day02.solve_part_2(@test_file_path)
  end
end
