class Article < ApplicationRecord
  has_many :comments

  after_create :release_date

  private

  def release_date
    self.release_date = Date.today
  end
end
