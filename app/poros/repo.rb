class Repo
  attr_reader :name

  def initialize(repo_data)
    @name = repo_data[:name].split("-").join(" ").capitalize
  end
end
