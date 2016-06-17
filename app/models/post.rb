class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category

  validates :title, presence: true, uniqueness: true, length: {minimum: 7}
  validates :body, presence: true

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def new_first_comments
    comments.order(created_at: :desc)
  end

  # def self.truncate(truncate)
  #   if body.length > 100
  #     truncate(body, :length => 97)
  #
  #   end

end
