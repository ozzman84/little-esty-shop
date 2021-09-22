class GithubService


  def get_data(url)
    response = Faraday.get("https://api.github.com/repos/isikapowers/little-esty-shop#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def pulls
    get_data("/pulls?state=closed&per_page=100")
  end

  def name
    get_data("")
  end

  def contributors
    data = get_data("/contributors")
    all_usernames = data.map do |hash|
      hash[:login]
    end
    all_usernames - ["BrianZanti", "timomitchel", "scottalexandra", "jamisonordway"]
  end

  def get_all
    result = {name: name, pulls: pulls, contributors: contributors}
  end
end
