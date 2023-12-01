defmodule Aoc2023.Day01 do
  # Because some written numbers are sharing the same letters, we can't just replace the written number with the digit from the start.
  @valid_spelled_numbers %{
    "one" => "o1e",
    "two" => "t2o",
    "three" => "thr3e",
    "four" => "fo4r",
    "five" => "fi5e",
    "six" => "s6x",
    "seven" => "sev7n",
    "eight" => "eig8t",
    "nine" => "ni9e"
  }

  def solve_part_1(input_file_path \\ "lib/aoc2023/day01/input.txt") do
    with {:ok, file_content} <- File.read(input_file_path),
         lines <- String.split(file_content, "\n") do
      common_solver(lines)
    end
  end

  def solve_part_2(input_file_path \\ "lib/aoc2023/day01/input.txt") do
    with {:ok, file_content} <- File.read(input_file_path),
         lines <- String.split(file_content, "\n") do
      lines
      |> Enum.map(&detect_and_transform_written_numbers/1)
      |> common_solver()
    end
  end

  defp common_solver(lines) do
    lines
    |> Enum.map(&extract_numbers_from_string/1)
    |> Enum.map(&extract_integer_value_from_list/1)
    |> Enum.sum()
  end

  defp extract_numbers_from_string(string) do
    string
    |> String.graphemes()
    |> Enum.filter(&String.match?(&1, ~r/\d/))
  end

  defp extract_integer_value_from_list([first_number | []]) do
    (first_number <> first_number)
    |> String.to_integer()
  end

  defp extract_integer_value_from_list([first_number | tail]) do
    [last_number | _] = Enum.reverse(tail)

    (first_number <> last_number)
    |> String.to_integer()
  end

  defp detect_and_transform_written_numbers(line),
    do:
      Enum.reduce(@valid_spelled_numbers, line, fn {written_number, digit_number}, acc ->
        String.replace(acc, written_number, digit_number)
      end)
end
