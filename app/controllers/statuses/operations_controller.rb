class Statuses::OperationsController < ApplicationController
	before_filter :authenticate_user!

	def favorite
		@status = Status.find(params[:id])
		current_user.fav! @status
		redirect_to :back, :notice => "Favorited sucessfully!"
	end

	def unfavorite
		@status = Status.find(params[:id])
		current_user.unfav! @status
		redirect_to :back, :notice => "Unfavorited sucessfully!"
	end

	def destroy
		@status = Status.find(params[:id])
		if @status.destroy
			redirect_to :back, :notice => "Destroyed sucessfully!"
		else
			redirect_to :back, :alert => "Error destroying!"
		end
	end

	def show
		@status = Status.find(params[:id])
	end
end
