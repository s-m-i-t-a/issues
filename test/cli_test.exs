defmodule CliTest do
  use ExUnit.Case, async: false

  import Issues.CLI, only: [
    parse_args: 1,
    decode_response: 1,
    sort_into_ascending_order: 1,
    convert_to_list_of_hashdicts: 1,
  ]
  import Mock

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "10"]) == {"user", "project", 10}
  end

  test "when two arguments is given, then count is default" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "with no arguments return :help" do
    assert parse_args([]) == :help
  end

  test "decode response return body, when :ok in response tuple" do
    assert decode_response({:ok, "body"}) == "body"
  end

  test "decode response end processing when :error is in response tuple" do
    with_mock System, [halt: fn(_) -> nil end] do
      decode_response({:error, [{"message", "ERROR"}]})

      assert called System.halt(2)
    end
  end

  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    data = for value <- values,
      do: [{"created_at", value}, {"other_data", "HUH"}]
    convert_to_list_of_hashdicts(data)
  end
end
