defmodule GithubIssuesTest do
  use ExUnit.Case, async: false

  import Mock

  test "issues url return string which contains user and project" do
    assert Issues.GithubIssues.issues_url("foo", "bar") == "https://api.github.com/repos/foo/bar/issues"
  end

  test_with_mock "fetch data from Github", HTTPoison,
    [get: fn(_url, _agent) -> %{status_code: 200, body: "[]"} end] do
      Issues.GithubIssues.fetch("foo", "bar")

      assert called HTTPoison.get(:_, :_)
  end

  test "return :error and body, when response code isn't ok" do
    with_mock HTTPoison,
      [get: fn(_url, _headers) -> %{status_code: 404, body: "error"} end] do
        assert Issues.GithubIssues.fetch("foo", "bar") == {:error, "error"}
      end
  end

  test "return :ok and body, when response code is ok" do
    with_mock HTTPoison,
      [get: fn(_url, _headers) -> %{status_code: 200, body: "[]"} end] do
        assert Issues.GithubIssues.fetch("foo", "bar") == {:ok, []}
      end
  end

  test "handle response return :ok and body when status code is 200" do
    body = []
    response = %{status_code: 200, body: :jsx.encode(body)}
    assert Issues.GithubIssues.handle_response(response) == {:ok, body}
  end

  test "handle response return :error and body when status code isn't 200" do
    body = "body"
    response = %{status_code: 500, body: body}
    assert Issues.GithubIssues.handle_response(response) == {:error, body}
  end
end
