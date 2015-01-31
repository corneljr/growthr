namespace :perform do 
	desc 'Like photos'
	task :like_photos => :environment do 
		like_photos
	end
end

def like_photos
	InstagramAccount.all.each do |account|
		client = Instagram.client(access_token: account.access_token)
		ids = client.tag_recent_media(account.hashtag).map(&:id)
		ids.each do |id|
			begin 
				puts client.like_media(id)
			rescue Instagram::Error => e
				puts e
			end
		end
	end
end