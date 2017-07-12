class Review < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  belongs_to :booking
end
