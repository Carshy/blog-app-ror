class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_post_counter
  after_destroy :decrease_posts_counter
  after_initialize :init

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def decrease_posts_counter
    author.decrement!(:posts_counter)
  end

  def init
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
