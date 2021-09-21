class ApplicationController < ActionController::Base
  before_action :name

  def name
   #json = GithubService.new.get_all
   @repo = Repo.new("json")
  end

  def welcome
  end
end
