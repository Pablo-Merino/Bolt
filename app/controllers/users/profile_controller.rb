class Users::ProfileController < ApplicationController
	before_filter :authenticate_user!
	def show
		@user = User.find_by(screen_name: params[:id])
	end
end
