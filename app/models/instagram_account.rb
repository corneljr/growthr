class InstagramAccount < ActiveRecord::Base

	def client
		client_id = AccountClient.find_by(instagram_account_id: self.id).instagram_client_id
		InstagramClient.find(client_id)
	end
end
