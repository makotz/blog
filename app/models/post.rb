class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category

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
