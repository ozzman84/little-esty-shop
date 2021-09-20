class GithubService
  def get_data
    response = Faraday.get("https://api.github.com/repos/isikapowers/little-esty-shop")
    JSON.parse(response.body, symbolize_names: true)
  end
end
