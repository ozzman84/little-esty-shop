class ApplicationController < ActionController::Base
  before_action :name

  def name
   json = GithubService.new.get_data
   @repo_name = Repo.new(json).name
  end

  def welcome
  end
end
