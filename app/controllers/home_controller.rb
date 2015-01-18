class HomeController < ApplicationController
  def index
  	@connected_account = InstagramAccount.find_by(username: params[:username])
  end
end
