# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShortenedUrlController' do
  # TODO: Extract the following shared examples into a helper module
  #     and include them in the specs when our test suite grows
  RSpec.shared_examples 'Returns JSON format' do
    it 'returns JSON format' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  RSpec.shared_examples 'Returns JSON error' do
    it 'returns JSON error' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  RSpec.shared_examples 'Returns a 422 status code' do
    it 'returns a 422 status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  RSpec.shared_examples 'Returns a 200 status code' do
    it 'returns a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
  end
  describe 'POST /encode' do
    context 'with valid input' do
      let(:original_url) { Faker::Internet.url }
      let(:shortened_url) { 'http://short.est/abc6de' }

      before do
        post '/encode', params: { url: original_url }
      end

      it 'returns a shortened URL' do
        expect(JSON.parse(response.body)).to include('short_url')
      end

      include_examples 'Returns JSON format'
      include_examples 'Returns a 200 status code'
    end

    context 'with invalid input' do
      before do
        post '/encode', params: { url: '' }
      end

      include_examples 'Returns JSON format'
      include_examples 'Returns a 422 status code'
      include_examples 'Returns JSON error'
    end
  end

  describe 'GET /decode' do
    let(:short_url) { "#{UrlEncodeService::BASE_URL}/abc6de" }
    let(:original_url) { Faker::Internet.url }

    context 'with valid input' do
      before do
        create(:shortened_url, original_url:, short_url:)

        get '/decode', params: { url: short_url }
      end

      it 'returns the original URL' do
        expect(JSON.parse(response.body)).to include('original_url')
      end

      include_examples 'Returns a 200 status code'
      include_examples 'Returns JSON format'
    end

    context 'with invalid input' do
      before do
        get '/decode', params: { short_url: "#{UrlEncodeService::BASE_URL}/invalid" }
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      include_examples 'Returns JSON format'
      include_examples 'Returns a 422 status code'
      include_examples 'Returns JSON error'
    end
  end
end
