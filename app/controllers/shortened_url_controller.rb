# frozen_string_literal: true

# Routing logic for ShortenedUrl
class ShortenedUrlController < ApplicationController
  def encode
    # Possible attack vector: SQL injection?
    # Possible attack vector: XSS?
    # Possible attack vector: CSRF?
    original_url = params[:url]

    short_url = UrlEncodeService.new(original_url).execute
    render json: { short_url: }
  end

  # def decode
  #   identifier = params[:identifier]
  #   short_link = ShortLink.find_by(identifier:))

  #   render json: { original_url: short_link.original_url }
  # end
end
