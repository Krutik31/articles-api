class Comment < ApplicationRecord
  belongs_to :article

  after_create :date_of_comment

  private

  def date_of_comment
    self.date_of_comment = Date.today
  end
end
