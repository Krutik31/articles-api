class Article < ApplicationRecord
  has_many :comments
  paginates_per 3

  after_create :release_date

  private

  def release_date
    self.release_date = Date.today
  end
end
