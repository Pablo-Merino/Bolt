class Event
	include Mongoid::Document
	include Mongoid::Timestamps
	include ActionView::Helpers::SanitizeHelper

  	field :name, type: String
	field :type, type: Symbol
	has_and_belongs_to_many :users
	before_save :sanitize_status



	def sanitize_status
		self.name = strip_tags(self.name)
	end
end
