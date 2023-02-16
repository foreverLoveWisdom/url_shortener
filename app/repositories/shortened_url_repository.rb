# frozen_string_literal: true

# Encapsulate database operations for ShortenedUrl
class ShortenedUrlRepository
  delegate :find_by, to: :model

  def initialize
    @model = ShortenedUrl
  end

  def create!(original_url, short_url)
    model.create!(original_url:, short_url:)
  end

  private

  attr_reader :model
end
