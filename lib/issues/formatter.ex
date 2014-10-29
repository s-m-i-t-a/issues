defmodule Issues.Formatter do

  import Enum, only: [
    map: 2,
    zip: 2
  ]

  def print_table_for_columns(rows, headers) do
    data = to_table(rows, headers)
    widths = width_of([headers| data])

    IO.inspect(widths)
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
end
