# frozen_string_literal: true

# Business logic for ShortenedUrl
class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true
  validates :short_url, presence: true, uniqueness: true
end
