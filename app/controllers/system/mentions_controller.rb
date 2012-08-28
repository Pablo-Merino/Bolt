class System::MentionsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@statuses = current_user.mentioned_statuses
	end
end
