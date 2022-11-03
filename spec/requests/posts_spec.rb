require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    context 'when request is sent' do
      it 'return the correct response' do
        get '/users/1/posts'
        expect(response).to have_http_status(200)
        expect(response.body).to render_template(:index)
        expect(response.body).to include('Lists posts from a specific user')
      end
    end
  end

  describe 'GET /show' do
    context 'when the request is sent' do
      it 'return the correct response' do
        get '/users/1/posts/1'
        expect(response).to have_http_status(200)
        expect(response.body).to render_template(:show)
        expect(response.body).to include('Shows posts from a specific user')
      end
    end
  end
end
