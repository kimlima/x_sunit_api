class Survivor < ApplicationRecord
  has_one :localization
  has_many :witnesses

  validates :name, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  
  # It bugs the Post request when uncommented
  # for reasons unknow to me
  # validates :abducted, presence: true
end
