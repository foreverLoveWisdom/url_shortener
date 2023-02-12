# frozen_string_literal: true

# Encapsulate database operations for ShortenedUrl
class ShortenedUrlRepository
  def initialize
    @model = ShortenedUrl
  end

  def find_by_short_url(short_url)
    model.find_by(short_url:)
  end

  def create!(original_url, short_url)
    model.create!(original_url:, short_url:)
  end

  private

  attr_reader :model
end
