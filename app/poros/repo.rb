class Repo
  atte_reader :name

  def initialize(repo_data)
    @name = repo_data[:name]
  end
end
