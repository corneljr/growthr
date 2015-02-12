namespace :perform do 
	desc 'Like photos'
	task :like_photos => :environment do 
		like_photos
	end
end

def like_photos
	InstagramAccount.where.not(access_token: nil).each do |account|
		set_client(account)
		client = Instagram.client(access_token: account.access_token)
		ids = client.tag_recent_media(account.hashtag).map(&:id)
		ids.first(15).each do |id|
			begin 
				puts "liking for #{account.username} -- #{Instagram.client_id}"
				puts client.like_media(id)
			rescue Instagram::Error => e
				puts e
			end
		end
	end
end

def set_client(instagram_account)
	client = instagram_account.client
	Instagram.configure do |config|
		config.client_id = client.client_id
		config.client_secret = client.client_secret
		config.client_ips = '127.0.0.1'
	end
end