require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'for the post model' do
    before(:each) do
      @user = User.new(name: 'James', bio: 'Rapper', posts_counter: 0)
      @post = Post.new(author: @user, title: 'Title', text: 'New song Here', likes_counter: 1, comments_counter: 4)
    end

    before { @post }

    it 'when title is nil' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'when max characters are 250' do
      @post.title = 'Title'
      expect(@post).to be_valid
    end

    it 'if likes counter is integer' do
      @post.likes_counter = 5
      expect(@post).to be_valid
    end

    it 'likes_counter is less than or eq to to 0' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end

    it 'comments_counter is greater than or eq to 0.' do
      @post.comments_counter = -2
      expect(@post).to_not be_valid
    end

    it 'if comments counter is not integer' do
      @post.comments_counter = 'come'
      expect(@post).to_not be_valid
    end

    it 'should return less than 5 comments ' do
      value = @post.recent_comments.length
      expect(value).to be < 5
    end
  end
end
