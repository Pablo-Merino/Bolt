class RegistrationsController < Devise::RegistrationsController
	def new
		i = Invite.all.entries.first.code
		if params[:code] != i
			redirect_to root_path, :alert => 'Wrong invite code'
		else
			super
		end
	end

	def create
		super
		
	end

	def update
		super
	end
end
