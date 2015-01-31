namespace :perform do 
	desc 'Update the skill ratings'
	task :like_photos => :environment do 
		like_photos
	end
end

def like_photos
	InstagramAccount.all.each do |account|
		client = Instagram.client(access_token: account.access_token)
		ids = client.tag_recent_media(tag).map(&:id)
		ids.each do |id|
			begin 
				client.like_media(id)
			rescue Instagram::Error => e
				puts e
			end
		end
	end
end