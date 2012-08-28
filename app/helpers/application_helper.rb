module ApplicationHelper
	require 'open-uri'

	def avatar_url(email)
		gravatar_id = Digest::MD5::hexdigest(email).downcase
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=400&d=identicon"
	end
end
