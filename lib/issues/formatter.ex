defmodule Issues.Formatter do
  def print_table_for_columns(rows, headers) do
    data = to_table(rows, headers)

    IO.inspect(data)
  end

  defp to_table(rows, headers) do
    for row <- rows do
      for header <- headers do
        row[header]
      end
    end
  end
end
