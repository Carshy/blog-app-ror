require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Testing validations For the Comment model' do
    before(:each) do
      @comment = Comment.new(text: 'My first comment for the post', author_id: 2)
    end
    before { @comment }

    it 'if post title is present' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'if author_id is an integer' do
      @comment.author_id = 'F'
      expect(@comment).to_not be_valid
    end

    it 'author_id is present' do
      @comment.author_id = false
      expect(@comment).to_not be_valid
    end

    it 'author_id is not present' do
      @comment.author_id = nil
      expect(@comment).to_not be_valid
    end
  end
end
