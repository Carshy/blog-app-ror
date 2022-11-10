require 'rails_helper'

RSpec.describe 'Posts show page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Developer', posts_counter: 0)

    @post = Post.create(title: 'My first post', text: 'My text', author: @user, likes_counter: 0, comments_counter: 0)

    @comment = Comment.create(text: 'My first comment', author: @user, post: @post)
    @like = Like.create(author_id: @user.id, post_id: @post.id)

    visit "/users/#{@user.id}/posts/#{@post.id}"
    # visit user_post_path(@user, @post)
  end

  describe 'Specs for view posts#show' do
    it 'I can see who wrote the post' do
      expect(page).to have_content 'Tom'
    end

    it 'I can see how many comments it has' do
      expect(page).to_not have_content 'Comments: '
    end

    it 'I can see how many likes it has' do
      expect(page).to_not have_content 'Likes: '
    end

    it 'Can see the post body' do
      expect(page).to have_content 'My text'
    end

    it 'Can see the username of each commentor' do
      expect(page).to have_content 'Tom'
    end

    it 'Can see the comment each commentor left' do
      expect(page).to have_content 'My first comment'
    end
  end
end