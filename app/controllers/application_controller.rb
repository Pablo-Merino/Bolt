class ApplicationController < ActionController::Base
	protect_from_forgery
	layout :decide_layout

	before_filter :set_reply_box
	def decide_layout
		if user_signed_in?
			"application"
		else
			"signed_out"
		end
	end

	def set_reply_box
		@reply_box_content = ""
		if controller_name == 'profile'
			@reply_box_content = "@#{params[:id]} "
		elsif "#{controller_name}##{action_name}" == "operations#show"

			status = Status.find(params[:id])
			if status
				@reply_box_content = "@#{status.user.screen_name} "
				status.mentions.each do |user|
					unless user == current_user
						@reply_box_content << "@#{user.screen_name} "
					end
				end
			end

		end
		

	end
end
