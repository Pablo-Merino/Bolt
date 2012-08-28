class System::GlobalController < ApplicationController
	before_filter :authenticate_user!

	def index
		@statuses = Status.all.entries
		events = Event.all.entries
		
		events.each do |event|
			@statuses << event
		end
		logger.info @statuses
		@statuses.sort_by! {|u| u.created_at}
		@statuses = @statuses.reverse

	end
end
