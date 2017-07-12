class User < ApplicationRecord
  include Clearance::User
  validates :email, uniqueness: true, presence: true
  validates :phone_number, presence: true, on: :update
  validates :government_id, presence: true, numericality: true, on: :update
  validates :birthday, presence: true, on: :update
  validates :autobiography, presence: true, on: :update
  validates :location, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :first_name, presence: true, on: :update
  validates :gender, presence: true, on: :update
  validates :password, presence: true,on: :create
  mount_uploader :avatar, AvatarUploader

  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :reviews
  has_many :bookings

  enum status: [:admin, :moderator, :customer]

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      #u.first_name = auth_hash["info"]["first_name"]
      # u.last_name = auth_hash["info"]["last_name"]
      # u.friendly_name = auth_hash["info"]["name"]
      #u.first_name = auth_hash["extra"]["raw_info"]["first_name"]
      #u.last_name = auth_hash["extra"]["raw_info"]["last_name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      #u.gender = auth_hash["extra"]["raw_info"]["gender"]
      #u.birthday = auth_hash["extra"]["raw_info"]["user_birthday"]

      u.password = SecureRandom.hex(6)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  # def password_optional?
  #   true
  # end

end
