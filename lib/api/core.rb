module Api
	class Core < Sinatra::Base

		before do
			content_type :json
		end

		# Nothing
		get '/' do
			authenticate

			{:error => true, :code => 100, :message => 'No action defined'}.to_json
		end

		# Shows your auth token
		post '/auth_token' do

			@user = User.find_by(screen_name: params[:user])
			if @user.valid_password?(params[:pass])
				{:error => false, :code => 201, :token => @user.authentication_token }.to_json
			else
				halt 403, {:error => true, :code => 101, :message => 'Wrong auth details'}.to_json
			end

		end


		get '/own/statuses' do
			authenticate

			{:error => false, :code => 202, :value => @user.statuses}.to_json
			
		end

		get '/own/user' do
			authenticate

			{:error => false, :code => 203, :value => @user.attributes.except("encrypted_password", "current_sign_in_ip", "current_sign_in_at", "last_sign_in_at", "last_sign_in_ip", "authentication_token") }.to_json

			
		end

		get '/own/followers' do
			authenticate

			return_followers = []
			@user.followers.each do |user|
				return_followers << user.attributes.except("encrypted_password", "current_sign_in_ip", "current_sign_in_at", "last_sign_in_at", "last_sign_in_ip", "authentication_token")
			end
			{:error => false, :code => 204, :value => return_followers}.to_json

			
		end

		get '/own/following' do
			authenticate

			return_following = []
			@user.following.each do |user|
				return_following << user.attributes.except("encrypted_password", "current_sign_in_ip", "current_sign_in_at", "last_sign_in_at", "last_sign_in_ip", "authentication_token")
			end
			{:error => false, :code => 205, :value => return_following}.to_json

			
		end

		get '/own/timeline' do
			authenticate

			@statuses = @user.status_from_following unless @user.status_from_following == nil

			{:error => false, :code => 206, :value => @statuses}.to_json

			
		end


		get '/status/:id' do |status_id|
			authenticate

			@status = Status.find(status_id)

			{:error => false, :code => 210, :value => @status}.to_json

			
		end

		get '/user/:id' do |user_id|
			authenticate

			@status = User.find(user_id).attributes.except("encrypted_password", "current_sign_in_ip", "current_sign_in_at", "last_sign_in_at", "last_sign_in_ip", "authentication_token")

			{:error => false, :code => 211, :value => @status}.to_json

			
		end

		get '/event/:id' do |event_id|
			authenticate

			@event = Event.find(event_id)
			{:error => false, :code => 212, :value => @event}.to_json

		end

		get '/global' do
			authenticate

			limit = 5

			if params[:limit]
				limit = params[:limit]
			end
			@statuses = Status.all.limit(limit).entries
			events = Event.all.limit(limit).entries
			
			events.each do |event|
				@statuses << event
			end
			logger.info @statuses
			@statuses.sort_by! {|u| u.created_at}
			@statuses = @statuses.reverse

			{:error => false, :code => 220, :value => @statuses}.to_json

		end

		def authenticate
			unless request.path == '/auth_token'
				begin
					@user = User.find_by(authentication_token: params[:auth_token])
					if @user
						#{:error => false, :code => 201, :token => @user.authentication_token }.to_json
						true

					else
						halt 403, {:error => true, :code => 101, :message => 'Wrong auth details'}.to_json
					end
				rescue
					halt 403, {:error => true, :code => 101, :message => 'Wrong auth details'}.to_json
				end
			end
		end
	end
end
