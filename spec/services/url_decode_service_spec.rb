# frozen_string_literal: true

require 'rails_helper'

describe UrlDecodeService do
  subject(:context) { described_class.new(short_url, shortened_url_repository).call }

  let(:result) { context.result }
  let(:shortened_url_repository) { instance_double(ShortenedUrlRepository) }

  describe '#call' do
    context 'when the shortened URL is valid' do
      let(:short_url) { "#{UrlEncodeService::BASE_URL}/abcde6" }
      let(:shortened_url) { instance_double(ShortenedUrl, original_url:) }
      let(:original_url) { Faker::Internet.url }

      before do
        allow(shortened_url_repository).to receive(:find_by).with(short_url:).and_return(shortened_url)
      end

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'returns the original URL' do
        expect(context.result).to eq(original_url)
      end
    end

    context 'when the shortened URL is invalid' do
      let(:invalid_short_url_message) { 'Error decoding URL: Invalid shortened URL' }

      RSpec.shared_examples 'Invalid shortened url message error' do
        it 'returns correct message' do
          expect(context.errors.full_messages.to_sentence).to eq('Invalid shortened url')
        end
      end

      context 'when a shortened URL does not exist in the database' do
        let(:short_url) { 'invalid' }

        before do
          allow(shortened_url_repository).to receive(:find_by).with(short_url:).and_return(nil)
        end

        it 'fails' do
          expect(context).to be_failure
        end

        include_examples 'Invalid shortened url message error'
      end

      context 'when the shortened URL is an empty string' do
        let(:short_url) { '' }

        before do
          allow(shortened_url_repository).to receive(:find_by).with(short_url:).and_return(nil)
        end

        it 'raises an error' do
          expect(context).to be_failure
        end

        include_examples 'Invalid shortened url message error'
      end

      context 'when the shortened URL is nil' do
        let(:short_url) { nil }

        before do
          allow(shortened_url_repository).to receive(:find_by).with(short_url:).and_return(nil)
        end

        it 'raises an error' do
          expect(context).to be_failure
        end

        include_examples 'Invalid shortened url message error'
      end

      context 'when the shortened URL contains spaces' do
        let(:short_url) { "#{UrlEncodeService::BASE_URL}/abc de5" }

        before do
          allow(shortened_url_repository).to receive(:find_by).with(short_url:).and_return(nil)
        end

        it 'raises an error' do
          expect(context).to be_failure
        end

        include_examples 'Invalid shortened url message error'
      end
    end
  end
end
