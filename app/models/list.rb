class List < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_one_attached :photo
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
end
