class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user, optional: true 
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  before_destroy :warning

  private

  def warning
    puts "Your post is about to be deleted"
  end

end
