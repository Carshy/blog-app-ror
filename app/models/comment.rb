class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_coments_counter

  def update_coments_counter
    post.increment!(:coments_counter)
  end
end
