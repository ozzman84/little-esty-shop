class ApiService
  def get_repo_data(endpoint)
    response = Faraday.get(endpoint) do |req|
      req.headers["Authorization"] = "token #{ENV['github_token']}"
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
