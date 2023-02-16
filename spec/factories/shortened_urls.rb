# frozen_string_literal: true

FactoryBot.define do
  factory :shortened_url do
    original_url { Faker::Internet.url }
    short_url { "#{UrlEncodeService::BASE_URL}/#{Faker::Alphanumeric.alphanumeric(number: 6)}" }
  end
end
