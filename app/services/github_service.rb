class GithubService < ApiService
  def repos
    repos_endpoint = "https://api.github.com/repos/isikapowers/little-esty-shop"
    get_data(repos_endpoint)
  end
end
