class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders
  def admin?
  	is_admin
  end
	def to_admin
		self.update_columns(is_admin: true)
	end

	def to_normal
		self.update_columns(is_admin: false)
	end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
