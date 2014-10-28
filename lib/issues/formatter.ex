defmodule Issues.Formatter do
  def print_table_for_columns(rows, headers) do
    data = to_table(rows, headers)

    IO.inspect(data)
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
end
