class Witness < ApplicationRecord
  belongs_to :survivor

  validates :witness_id, presence: true
end
