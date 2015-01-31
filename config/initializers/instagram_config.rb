Instagram.configure do |config|
	config.client_id = ENV['instagram_client_id']
	config.client_secret = ENV['instagram_client_secret']
	config.client_ips = '127.0.0.1'
end