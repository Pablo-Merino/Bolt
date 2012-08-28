class Status
	include Mongoid::Document
	include Mongoid::Timestamps
	include Twitter::Extractor
	include ActionView::Helpers::SanitizeHelper

	require 'cgi'

	field :text, type: String
	field :html, type: String
	validates_presence_of :text
	validates_length_of :text, minimum: 1, maximum: 256

	belongs_to :user, :inverse_of => :statuses
	has_and_belongs_to_many :mentions, :class_name=>'User', :inverse_of => :mentioned_statuses

	default_scope order_by(:created_at => :desc)

	before_save :generate_html


	belongs_to :reply, class_name:'Status', :inverse_of => nil

	def is_mine?(current_user)
		self.user == current_user
	end

	def generate_html
		out = CGI.escapeHTML(self.text)
		out.gsub!(/(http[s]?:\/\/\S+[a-zA-Z0-9\/}])/, "<a href='\\1'>\\1</a>")
		out.gsub!(/(^|\s)@(\w+)/, "\\1<a href=\"/user/\\2\">@\\2</a>") 
		out.gsub!(/(^|\s+)#(\w+)/, "\\1<a href=\"/search/\\2\">#\\2</a>")
		self.html = out
	end

end
