class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
  end
end
