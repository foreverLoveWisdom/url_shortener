# frozen_string_literal: true

# Encode the original URL to a shortened URL
class UrlEncodeService
  prepend SimpleCommand
  include ActiveModel::Validations

  NUM_CHARS = 6
  BASE_URL = 'http://short.est'

  # Initializes a new instance of the UrlEncodeService class.
  #
  # @param [String] original_url The original URL that will be encoded to a shortened URL.
  # @param [ShortenedUrlRepository] repository The repository where the shortened URL will be stored.
  #
  # @return [UrlEncodeService] A new instance of the UrlEncodeService class.
  def initialize(original_url, repository = ShortenedUrlRepository.new)
    @original_url = original_url
    @repository = repository
  end

  def call
    while true
      shortened_url = generate_short_url
      break unless ShortenedUrl.exists?(short_url: shortened_url)
    end

    repository.create!(original_url, shortened_url)
    shortened_url
  rescue ActiveRecord::RecordInvalid
    add_encode_url_error
  end

  private

  attr_reader :original_url, :repository

  def add_encode_url_error
    errors.add(:base, :encode_url_error)
    nil
  end

  def generate_short_url
    chars = generate_list_of_chars
    short_url = chars.sample(NUM_CHARS)

    "#{BASE_URL}/#{short_url}"
  end

  def generate_list_of_chars
    ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  end
end
