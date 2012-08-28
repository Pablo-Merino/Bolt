class System::TimelineController < ApplicationController
	before_filter :authenticate_user!
	def index
		
		@statuses = current_user.status_from_following unless current_user.status_from_following == nil
	end
end
