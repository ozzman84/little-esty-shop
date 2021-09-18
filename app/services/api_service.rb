class ApiService
  def get_repo_data(endpoint)
    response = Faraday.get(endpoint) do |req|
      req.headers["Authorization"] = "token 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"
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
