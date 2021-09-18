class ApplicationController < ActionController::Base
  def names
   json = GithubService.new.repos
   @repo_name = Repo.new(json).name
  end

  def welcome
  end
end
