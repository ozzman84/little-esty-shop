class ApplicationController < ActionController::Base
  before_action :name

  def name
   json = GithubService.new.get_data
   @repo = Repo.new(json)
  end

  def welcome
  end
end
