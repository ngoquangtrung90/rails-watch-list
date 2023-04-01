class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :rating, comparison: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_blank: true

  has_many :bookmarks
  has_many :lists, through: :bookmarks

  before_destroy :check_bookmark

  private

  def check_bookmark
    if bookmarks.any?
      raise ActiveRecord::InvalidForeignKey.new
    end
  end
end
