class Repo
  attr_reader :name, :pulls, :contributors

  def initialize(repo_data)
    @name = repo_data[:name][:name].split("-").join(" ").capitalize
    @pulls = repo_data[:pulls].count
    @contributors = repo_data[:contributors]
    @commits = repo_data[:commits]
  end
end
