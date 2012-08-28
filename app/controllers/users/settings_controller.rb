class Users::SettingsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@user = User.find(current_user.id)
	end

	def update

		@user = User.find(current_user.id)
		@old_user = @user.dup
		if @user.valid_password?(params[:user][:old_password])

			@user.name = params[:user][:name] unless params[:user][:name].empty?
			@user.screen_name = params[:user][:screen_name] unless params[:user][:screen_name].empty?
			@user.email = params[:user][:email] unless params[:user][:email].empty?
			@user.biography = params[:user][:biography] unless params[:user][:biography].empty?		
			@user.password = params[:user][:password] unless params[:user][:password].empty?
			if @user.screen_name_changed?
				e = Event.new(:name => "@#{@old_user.screen_name} is now called @#{@user.screen_name}!", :type => :new_nick)
				e.users << @user
				e.save
			end
			if @user.save
				sign_in @user, :bypass => true
				redirect_to settings_path, :notice => "Updated succesfully."
			else
				redirect_to settings_path, :alert => "Error updating."
			end

		else
			redirect_to settings_path, :alert => "Error updating - wrong password."
		end
	end
end
