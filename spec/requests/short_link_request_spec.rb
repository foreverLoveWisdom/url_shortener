# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShortenedUrl' do
  describe 'POST /encode' do
    context 'with valid params' do
      let(:encode_url) { post '/encode', params: { url: 'https://www.google.com' } }

      it 'return success status' do
        encode_url
        expect(response).to have_http_status(:success)
      end

      it 'returns a shortened URL' do
        encode_url
        expect(response.body).to include('short_url')
      end
    end
  end

  # describe 'GET /decode' do
  #   it 'returns the original URL' do
  #     short_link = ShortLink.create!(
  #       original_url: 'https://www.google.com',
  #       shortened_url: 'http://localhost:3000/1',
  #       identifier: '1'
  #     )

  #     get "/decode/#{short_link.identifier}"

  #     expect(response).to have_http_status(:ok)
  #     expect(response.body).to include('original_url')
  #   end
  # end
end
