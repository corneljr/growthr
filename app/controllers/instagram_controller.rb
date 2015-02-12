class InstagramController < ApplicationController

  def create
    @instagram_client = InstagramClient.find_by(used: false)

    Instagram.configure do |config|
      config.client_id = @instagram_client.client_id
      config.client_secret = @instagram_client.client_secret
      config.client_ips = '127.0.0.1'
    end

    redirect_to Instagram.authorize_url(:redirect_uri => ENV['instagram_callback'], :scope => 'likes')

  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['instagram_callback'])
    
  	if response.access_token
  		@instagram = InstagramAccount.create(username: response.user.username, access_token: response.access_token)
  	end

    @client = InstagramClient.find_by(client_id: Instagram.client_id)
  	redirect_to root_path({username: @instagram.username, client: @client.id})
  end

  def update
    @instagram_client = InstagramClient.find(params[:client_id])
  	@instagram_account = InstagramAccount.find(params[:account_id])
    Stripe.api_key = ENV['stripe_secret_key']

    begin

      customer = Stripe::Customer.create(description: @instagram_account.username, plan: params[:plan_id], card: params[:stripe_card_token])
    	@instagram_account.update(hashtag: params[:hashtag], stripe_token: customer.id)

      AccountClient.create(instagram_account_id: @instagram_account.id, instagram_client_id: @instagram_client.id)
      @instagram_client.update(used: true)

      redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end
end
