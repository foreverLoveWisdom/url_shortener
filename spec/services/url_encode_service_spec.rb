# frozen_string_literal: true

require 'rails_helper'

describe UrlEncodeService do
  subject(:encoded_url) { described_class.new(original_url, repository).execute }

  let(:original_url) { 'http://example.com' }
  let(:repository) { instance_double(ShortenedUrlRepository) }

  describe '#execute' do
    context 'when the URL is successfully shortened' do
      before do
        allow(repository).to receive(:create!).and_return(true)
      end

      it 'returns the shortened URL' do
        expect(encoded_url).to be_a(String)
      end

      it 'starts with the base URL' do
        expect(encoded_url).to start_with(UrlEncodeService::BASE_URL)
      end

      it 'creates a new shortened URL in the repository' do
        encoded_url

        expect(repository).to have_received(:create!).with(original_url, anything)
      end
    end

    context 'when the URL cannot be shortened' do
      before do
        allow(repository).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'raises an error' do
        expect { encoded_url }.to raise_error('Error encoding URL: Record invalid')
      end
    end
  end
end
