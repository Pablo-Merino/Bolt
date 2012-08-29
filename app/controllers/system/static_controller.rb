class System::StaticController < ApplicationController
	before_filter :authenticate_user!, :only => [:api]
	def index
		if user_signed_in?
			redirect_to timeline_path
		end
	end

	def about
	end

	def api
	end
end
