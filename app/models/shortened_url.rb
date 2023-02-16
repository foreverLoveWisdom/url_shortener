# frozen_string_literal: true

# Business logic for ShortenedUrl
class ShortenedUrl < ApplicationRecord
  # 2000 characters is a safe number: https://stackoverflow.com/questions/417142/what-is-the-maximum-length-of-a-url-in-different-browsers
  validates :original_url, presence: true, length: { maximum: 2000 }
  validates :short_url, presence: true, uniqueness: true
end
