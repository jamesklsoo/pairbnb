class Listing < ApplicationRecord
  validates :name, presence: true
  mount_uploaders :photos, AvatarUploader

  scope :search, -> (search) {where("name LIKE ? OR description LIKE ? OR city LIKE ?", "%#{search.capitalize}%", "%#{search.capitalize}%", "%#{search.capitalize}%")}


  belongs_to :user
  has_many :bookings
  has_many :reviews
  self.per_page = 5

  acts_as_taggable
  acts_as_taggable_on :categories

  def self.look(location, start_date, end_date, pax)
    where("state LIKE ? OR country LIKE ? OR city LIKE ? AND date_start >= ? AND date_end <= ? AND number_of_guests >= ?", "%#{location.capitalize}%", "%#{location.capitalize}%","%#{location.capitalize}%","#{start_date}", "#{end_date}", "#{pax}")

  end
end
