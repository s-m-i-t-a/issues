defmodule Issues.GithubIssues do

  @user_agent [{"User-agent", "Elixir smitka.j@gmail.com"}]

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def handle_response(%{status_code: 200, body: body}) do
    {:ok, :jsx.decode(body)}
  end
  def handle_response(%{status_code: ___, body: body}), do: {:error, body}
end
