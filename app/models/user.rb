class User
	include Mongoid::Document
	include ActionView::Helpers::SanitizeHelper

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

	## Database authenticatable
	field :email,              :type => String, :default => ""
	field :encrypted_password, :type => String, :default => ""

	field :screen_name, :type => String
	field :name, :type => String

	field :biography, :type => String, :default => ''

	field :admin, :type => Boolean, :default => false

	validates_presence_of :email
	validates_presence_of :screen_name
	validates_presence_of :name
	validates_presence_of :encrypted_password
	validates_uniqueness_of :screen_name
	## Recoverable
	field :reset_password_token,   :type => String
	field :reset_password_sent_at, :type => Time

	## Rememberable
	field :remember_created_at, :type => Time

	## Trackable
	field :sign_in_count,      :type => Integer, :default => 0
	field :current_sign_in_at, :type => Time
	field :last_sign_in_at,    :type => Time
	field :current_sign_in_ip, :type => String
	field :last_sign_in_ip,    :type => String

	## Confirmable
	# field :confirmation_token,   :type => String
	# field :confirmed_at,         :type => Time
	# field :confirmation_sent_at, :type => Time
	# field :unconfirmed_email,    :type => String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
	# field :locked_at,       :type => Time

	## Token authenticatable
	field :authentication_token, :type => String

	has_many :statuses
	has_and_belongs_to_many :favorites, class_name:'Status'
	has_and_belongs_to_many :mentioned_statuses, class_name:'Status', :inverse_of => :mentions

	has_and_belongs_to_many :following, class_name: 'User', inverse_of: :followers, autosave: true
	has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following, autosave: true

	has_and_belongs_to_many :events
	
	before_save :ensure_authentication_token
	before_save :sanitize_status
	after_create :create_event

	def follows?(user)
		self.following.include?(user)
	end


	def follow!(user)
		self.following << user
		e = Event.new(:name => "#{user.name} started following #{self.name}!", :type => :follow)
		e.users << self
		e.users << user
		e.save
	end

	def unfollow!(user)
		self.following.delete(user)
	end

	def status_from_following
		statuses = Array.new
		self.following.each do |user|
			user.statuses.each do |p|
				statuses << p
			end
		end
		self.statuses.each do |status|
			statuses << status
		end

		statuses.sort! { |a,b| a.created_at <=> b.created_at }.reverse


	end

	def fav!(status)
		self.favorites << status
	end

	def unfav!(status)
		self.favorites.delete(status)
	end

	def faved?(status)
		self.favorites.include?(status)
	end

	def admin?
		admin
	end

	def sanitize_status
		self.screen_name = strip_tags(self.screen_name)
		self.biography = strip_tags(self.biography)
		self.name = strip_tags(self.name)

	end

	def create_event
		e = Event.new(:name => "#{self.name} joined Bolt!", :type => :new_user)
		e.users << self
		e.save
	end
end
