defmodule Aoc2023.Day02 do
  @limits %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def solve_part_1(input_file_path \\ "lib/aoc2023/day02/input.txt") do
    with {:ok, file_content} <- File.read(input_file_path),
         lines <- String.split(file_content, "\n") do
      lines
      |> Enum.map(&transform_game_line/1)
      |> Enum.filter(&is_valid_game?/1)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
    end
  end

  def solve_part_2(input_file_path \\ "lib/aoc2023/day02/input.txt") do
    with {:ok, file_content} <- File.read(input_file_path),
         lines <- String.split(file_content, "\n") do
      lines
      |> Enum.map(&extract_games/1)
      |> Enum.map(&get_min_cubes/1)
      |> Enum.map(&calc_power/1)
      |> Enum.sum()
    end
  end

  defp transform_game_line(line) do
    [game | [sets]] = String.split(line, ": ")
    [game_number | _] = Regex.run(~r/\d+/, game)

    {String.to_integer(game_number), transform_sets(sets)}
  end

  defp extract_games(line) do
    [_game | [sets]] = String.split(line, ": ")

    sets
    |> String.split("; ")
    |> Enum.map(&transform_set/1)
    |> Enum.flat_map(& &1)
  end

  defp transform_sets(sets) do
    sets
    |> String.split("; ")
    |> Enum.map(&transform_set/1)
  end

  defp transform_set(set) do
    set
    |> String.split(", ")
    |> Enum.map(&transform_color_and_number/1)
  end

  defp transform_color_and_number(color_and_number) do
    [number, color] = String.split(color_and_number, " ")
    {color, String.to_integer(number)}
  end

  defp is_valid_game?({_, sets}) do
    sets
    |> Enum.flat_map(& &1)
    |> Enum.all?(fn {color, number} ->
      number <= @limits[color]
    end)
  end

  defp get_min_cubes(sets) do
    Enum.reduce(sets, %{"red" => 0, "green" => 0, "blue" => 0}, fn {color, number}, acc ->
      if number > acc[color] do
        Map.put(acc, color, number)
      else
        acc
      end
    end)
  end

  defp calc_power(%{"red" => red, "green" => green, "blue" => blue}), do: red * green * blue
end
