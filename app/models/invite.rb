class Invite
	include Mongoid::Document
	include Mongoid::Timestamps

	field :code, type: String

	default_scope order_by(:created_at => :desc)

	before_save :gen_code

	def gen_code
		self.code = rand(36**8).to_s(36)
	end

end
