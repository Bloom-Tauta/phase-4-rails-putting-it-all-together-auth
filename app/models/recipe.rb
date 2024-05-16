class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates: instructions, length: { minum: 50 }
end
