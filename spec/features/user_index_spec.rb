require 'rails_helper'

RSpec.describe 'Testing user index page', type: :feature do
  describe 'Get user index' do
    before(:each) do
      @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Mexico.')
      @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                 bio: 'Teacher from Poland.')
    end

    scenario 'shows user content on screen' do
      visit users_path
      sleep(8)
      expect(page).to have_content('List of All Users')
    end

    feature 'user index' do
      background { visit users_path }
      scenario 'See all users' do
        expect(page).to have_content('Tom')
        expect(page).to have_content('Lilly')
      end

      scenario 'See number of posts by each user' do
        expect(page).to have_content('Number of Posts:')
      end

      scenario 'See the profile picture for each user' do
        expect(page.first('img')['src']).to have_content 'https://unsplash.com/photos/F_-0BxGuVvo'
      end

      scenario 'When I click on a user, I am redirected to that user show page' do
        click_link 'Tom', match: :first
        expect(current_path).to eq user_path(User.first.id)
      end
    end
  end
end
