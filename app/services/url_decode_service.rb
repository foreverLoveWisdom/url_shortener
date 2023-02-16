# frozen_string_literal: true

# Decode the shortened URL to the original URL
class UrlDecodeService
  prepend SimpleCommand
  include ActiveModel::Validations

  # Initializes a new instance of the UrlDecodeService class.
  #
  # @param [String] url The shortened URL that will be decoded to the original URL.
  # @param [ShortenedUrlRepository] repository The repository where the original URL is stored.
  #
  # @return [UrlDecodeService] A new instance of the UrlDecodeService class.
  #
  # @note The UrlDecodeService assumes that the shortened URL has already been stored
  #   in the repository with its corresponding original URL. If the shortened URL is not
  #   in the repository, the decoding process will fail and return nil.
  def initialize(url, repository = ShortenedUrlRepository.new)
    @url = url
    @repository = repository
  end

  def call
    shortened_url = repository.find_by(short_url: url)
    return nil unless valid_shortened_url?(shortened_url)

    shortened_url.original_url
  end

  private

  attr_reader :url, :repository

  def valid_shortened_url?(shortened_url)
    if shortened_url.blank?
      errors.add(:base, :invalid_shortened_url)
      false
    else
      true
    end
  end
end
