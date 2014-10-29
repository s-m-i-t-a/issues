defmodule FormatterTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureIO

  import Issues.Formatter, only: [print_table_for_columns: 2]

  # test "to table return only selected columns" do
  #   data = [
  #     %{"foo" => 1, "bar" => 2, "baz" => 3},
  #     %{"foo" => 4, "bar" => 5, "something" => 6},
  #   ]

  #   result = Issues.Formatter.to_table(data, ["foo", "bar"])

  #   assert result == [[1,2], [4,5]]
  # end

  def headers, do: ["c1", "c2", "c4"]

  def simple_test_data do
    [
      %{"c1" => "r1 c1", "c2" => "r1 c2",  "c3" => "r1 c3", "c4" => "r1+++c4"},
      %{"c1" => "r2 c1", "c2" => "r2 c2",  "c3" => "r2 c3", "c4" => "r2 c4"},
      %{"c1" => "r3 c1", "c2" => "r3 c2",  "c3" => "r3 c3", "c4" => "r3 c4"},
      %{"c1" => "r4 c1", "c2" => "r4++c2", "c3" => "r4 c3", "c4" => "r4 c4"},
    ]
  end

  test "output is correct" do
    output = capture_io fn ->
      print_table_for_columns(simple_test_data, headers)
    end

    result = output
    |> String.split("\n")
    |> Enum.map_join("\n", &String.rstrip/1)

    assert result == """
     c1    | c2     | c4
    -------+--------+--------
     r1 c1 | r1 c2  | r1+++c4
     r2 c1 | r2 c2  | r2 c4
     r3 c1 | r3 c2  | r3 c4
     r4 c1 | r4++c2 | r4 c4
    """
  end
end
