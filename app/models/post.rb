class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  def favorited?(user)
    favorites.exists?(user: user)
  end

  def favorite_for(user)
    favorites.find_by_user_id user
  end

  validates(:title, {presence: true, uniqueness: true })

  # def self.search(search)
  #   if search
  #     find(Post.ids, :conditions => ['title LIKE ?', "%#{search}%"])
  #   else
  #     find(Post.ids)
  #   end
  # end
  before_save :create_keywords


  def self.search(search)
  search_condition = "%" + search + "%"
  where(['keywords ILIKE ?', search_condition])
  end

  def create_keywords
    self.keywords = [title, body].map(&:downcase).join(' ')
  end
end
