require 'rails_helper'

RSpec.describe 'Testing user show page', type: :feature do
  describe 'Get user show action' do
    before(:each) do
      @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Mexico.')

      @first_post = Post.create(author_id: @first_user, text: 'post text', title: 'post title')
      @first_post.save
    end

    scenario 'shows user content on screen' do
      visit users_path
      sleep(8)
      expect(page).to have_content('List of All Users')
    end

    feature 'user show page' do
      background { visit user_path(User.first.id) }
      scenario "I can see the user's profile" do
        expect(page.first('img')['src']).to have_content('https://unsplash.com/photos/F_-0BxGuVvo')
      end

      scenario "I can see the user's username" do
        expect(page).to have_content('Tom')
      end

      scenario "I can see the user's bio" do
        expect(page).to have_content('Teacher from Mexico.')
      end

      scenario "I can see a button that lets me view all of a user's posts" do
        click_link('See All Posts')
        expect(current_path).to eq user_posts_path(User.first.id)
      end
    end
  end
end
