# frozen_string_literal: true

# Url decode service logic
class UrlDecodeService
  def initialize(url, repository = ShortenedUrlRepository.new)
    @url = url
    @repository = repository
  end

  def execute
    shortened_url = repository.find_by(short_url: url)
    raise 'Error decoding URL: Invalid shortened URL' if shortened_url.nil?

    shortened_url.original_url
  end

  private

  attr_reader :url, :repository
end
