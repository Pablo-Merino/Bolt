module Users::SettingsHelper
	# Get the resource name
	def resource_name
		:user
	end

	# Get the resource.
	# If the @user variable already exists return it
	# If not make a new instance and set the @user variable to it
	def resource
		@user ||= User.new
	end

	# Get the devise mapping
	# If the @devise_mapping variable already exists return it
	# If not make a new instance and set the @devise_mapping variable to it
	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end
