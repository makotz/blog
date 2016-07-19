class User < ActiveRecord::Base
  before_create { generate_token(:auth_token) }

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


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post#tells ruby which model to lead to since posts is already taken


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


end
