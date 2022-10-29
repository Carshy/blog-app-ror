require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'testing validations for User model' do
    before(:each) do
      @user = User.new(name: 'Carshy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Rapper')
    end

    before { @user }

    it 'if user name is present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'if user name is not a string' do
      @user.name = 7
      expect(@user).to_not be_valid
    end

    it 'if user photo url not a string' do
      @user.photo = 1
      expect(@user).to_not be_valid
    end

    it 'if user posts_counter is be greater than or eq to zero' do
      @user.posts_counter = -1
      expect(@user).to_not be_valid
    end

    it 'if posts_counter is be greater than or eq to zero' do
      @user.posts_counter = 2
      expect(@user).to be_valid
    end

    it 'should return less than 5 posts ' do
      value = @user.recent_posts.length
      expect(value).to be < 5
    end
  end
end
