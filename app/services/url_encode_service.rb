# frozen_string_literal: true

# Url encode service logic
# Copy simple command code and paste it here
class UrlEncodeService
  NUM_CHARS = 6
  BASE_URL = 'http://short.est'

  def initialize(original_url, repository = ShortenedUrlRepository.new)
    @original_url = original_url
    @repository = repository
  end

  def execute
    while true
      shortened_url = generate_short_url
      break unless ShortenedUrl.exists?(short_url: shortened_url)
    end

    repository.create!(original_url, shortened_url)
    shortened_url
  rescue ActiveRecord::RecordInvalid => e
    raise "Error encoding URL: #{e.message}"
  end

  private

  attr_reader :original_url, :repository

  def generate_short_url
    chars = generate_list_of_chars
    short_url = chars.sample(NUM_CHARS)

    "#{BASE_URL}/#{short_url}"
  end

  def generate_list_of_chars
    ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  end
end
