class Repo
  attr_reader :name, :pulls

  def initialize(repo_data)
    @name = repo_data[:name][:name].split("-").join(" ").capitalize
    @pulls = repo_data[:pulls].count
  end
end
