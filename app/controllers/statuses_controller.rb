class StatusesController < ApplicationController
	before_filter :authenticate_user!
	# GET /statuses
	# GET /statuses.json
	def index
		@statuses = Status.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @statuses }
		end
	end

	# GET /statuses/1
	# GET /statuses/1.json
	def show
		@status = Status.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @status }
		end
	end

	# GET /statuses/new
	# GET /statuses/new.json
	def new
		@status = Status.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @status }
		end
	end

	# GET /statuses/1/edit
	def edit
		@status = Status.find(params[:id])
	end

	# POST /statuses
	# POST /statuses.json
	def create

		@status = Status.new(params[:status])

		current_user.statuses << @status
		@status.user = current_user

		if params[:status][:reply_id]
			replied_to = Status.find(params[:status][:reply_id])
			@status.reply = replied_to
		end

		usernames = Twitter::Extractor.extract_mentioned_screen_names(@status.text)
		usernames.each do |user|
			begin
				u = User.find_by(screen_name: user)
				u.mentioned_statuses << @status
				@status.mentions << u
			rescue Exception => e
			end

		end

		respond_to do |format|
			if @status.save
				format.html { redirect_to :back, :notice =>'Status was successfully created.' }
				format.json { render json: @status, status: :created, location: @status }
			else
				if params[:status][:text].length > 256
					format.html { redirect_to :back, :alert => 'The status needs to have 256 or less characters!' }
				else
					format.html { redirect_to :back, :alert => 'You need some text for the status!' }
				end
				format.json { render json: @status.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /statuses/1
	# PUT /statuses/1.json
	def update
		@status = Status.find(params[:id])

		respond_to do |format|
			if @status.update_attributes(params[:status])
				format.html { redirect_to @status, notice: 'Status was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @status.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /statuses/1
	# DELETE /statuses/1.json
	def destroy
		@status = Status.find(params[:id])
		@status.destroy

		respond_to do |format|
			format.html { redirect_to :back }
			format.json { head :no_content }
		end
	end
end
