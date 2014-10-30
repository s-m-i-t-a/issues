defmodule Issues.Formatter do

  import Enum, only: [
    map: 2,
    zip: 2,
    map_join: 3,
  ]

  def print_table_for_columns(rows, headers) do
    data = to_table(rows, headers)
    widths = width_of([headers| data])
    format = format_row(widths)

    print_line(format, headers)
    hr(widths)
    print_data(format, data)
  end

  defp to_table(rows, headers) do
    for row <- rows do
      for header <- headers do
        printable(row[header])
      end
    end
  end

  defp printable(str) when is_binary(str), do: str
  defp printable(str), do: to_string(str)

  defp width_of(list) do
    width_of(list, [])
  end
  defp width_of([], result), do: result
  defp width_of([head | tail], []) do
    result = head |> map(&String.length/1)
    width_of(tail, result)
  end
  defp width_of([head | tail], result) do
    result = for {i1, i2} <- zip(head, result) do
      max(String.length(i1), i2)
    end

    width_of(tail, result)
  end

  defp format_row(widths) do
      " " <> map_join(widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  defp hr(widths) do
    IO.puts("-" <> map_join(widths, "-+-", fn width -> List.duplicate("-", width) end))
  end

  defp print_line(format, fields) do
    :io.format(format, fields)
  end

  defp print_data(_format, []), do: :ok
  defp print_data(format, [head | tail]) do
    print_line(format, head)
    print_data(format, tail)
  end
end
