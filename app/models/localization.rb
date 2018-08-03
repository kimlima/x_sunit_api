class Localization < ApplicationRecord
  belongs_to :survivor
  
  validates :latitude, presence: true
  validates :longitude, presence: true
end
