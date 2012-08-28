class Users::OperationsController < ApplicationController
	before_filter :authenticate_user!

	def follow
		@user = User.find_by(screen_name:params[:id])
		current_user.follow!(@user)
		redirect_to user_profile_path(@user.screen_name),:notice =>'Following!'
	end

	def unfollow
		@user = User.find_by(screen_name:params[:id])
		current_user.unfollow!(@user)
		redirect_to user_profile_path(@user.screen_name),:notice =>'Unfollowed!'
	end
end
