class InstagramController < ApplicationController

  def create
  	redirect_to Instagram.authorize_url(:redirect_uri => 'https://stormy-stream-5423.herokuapp.com/auth/instagram/callback', :scope => 'likes')
  end

  def callback
  	response = Instagram.get_access_token(params[:code], :redirect_uri => 'https://stormy-stream-5423.herokuapp.com/auth/instagram/callback')
    
  	if response.access_token
  		@instagram = InstagramAccount.create(username: response.user.username, access_token: response.access_token)
  	end

  	redirect_to root_path({username: @instagram.username})
  end

  def update
  	@instagram_account = InstagramAccount.find(params[:account_id])
  	@instagram_account.update(hashtag: params[:hashtag])
    redirect_to root_path
  end
end
