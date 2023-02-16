# frozen_string_literal: true

require 'rails_helper'

describe UrlEncodeService do
  subject(:context) { described_class.new(original_url, repository).call }

  let(:result) { context.result }
  let(:original_url) { Faker::Internet.url }
  let(:repository) { instance_double(ShortenedUrlRepository) }

  describe '#call' do
    context 'when the URL is successfully shortened' do
      before do
        allow(repository).to receive(:create!).and_return(true)
      end

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'returns the shortened URL' do
        expect(result).to be_a(String)
      end

      it 'starts with the base URL' do
        expect(result).to start_with(UrlEncodeService::BASE_URL)
      end

      it 'creates a new shortened URL in the repository' do
        context

        expect(repository).to have_received(:create!).with(original_url, anything)
      end
    end

    context 'when the URL cannot be shortened' do
      let(:error_message) { 'Encoding url error' }

      before do
        allow(repository).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'fails' do
        expect(context).to be_failure
      end

      it 'returns correct message error' do
        expect(command_service_error).to eq(error_message)
      end
    end
  end
end
