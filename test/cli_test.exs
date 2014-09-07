defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1]

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
end
