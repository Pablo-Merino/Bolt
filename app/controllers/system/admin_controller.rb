class System::AdminController < ApplicationController
	before_filter :check_admin
	
	def check_admin
		if authenticate_user! and current_user.admin?
			true
		else
			if user_signed_in?
				redirect_to root_path
			else
				redirect_to new_user_session_path
			end
		end
	end

	def index
		@i = Invite.all.entries.first.code

	end

	def regen
		i = Invite.new
		if i.save
			redirect_to :back, :notice => 'New invite code succesfully generated'
		else
			redirect_to :back, :notice => 'Error generating new invite code!'
		end
	end
end
