require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get hello' do
    get posts_hello_url
    assert_response :success
  end
end
