class Repo
  attr_reader :name, :pulls

  def initialize(repo_data)
    @name =  "little esty shop"#repo_data[:name][:name].split("-").join(" ").capitalize
    @pulls =  35 #repo_data[:pulls].count
  end
end
