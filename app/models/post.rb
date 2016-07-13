class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, uniqueness: true, length: {minimum: 7}
  validates :body, presence: true

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def new_first_comments
    comments.order(created_at: :desc)
  end

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourited_for(user)
    favourites.find_by_user_id user
  end

  # def self.truncate(truncate)
  #   if body.length > 100
  #     truncate(body, :length => 97)
  #
  #   end

end
