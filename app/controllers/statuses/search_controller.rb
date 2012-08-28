class Statuses::SearchController < ApplicationController
	def show
		@statuses = Status.where(:text => /#{Regexp.quote(params[:search])}\b/i).entries

	end

	def gateway
		redirect_to search_path(params[:status][:text])
	end
end
