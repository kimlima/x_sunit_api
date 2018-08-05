class Report < ApplicationRecord
  validates :abducted_quantity, presence: true
  validates :survivors_quantity, presence: true
end
