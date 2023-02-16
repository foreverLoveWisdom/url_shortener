# frozen_string_literal: true

# Routing logic for ShortenedUrl
class ShortenedUrlController < ApplicationController
  before_action :sanitize_params, only: %i[encode decode]

  def encode
    url_encode_service = UrlEncodeService.call(@url)

    if url_encode_service.success?
      render_json(short_url: url_encode_service.result)
    else
      render_command_service_error_json(url_encode_service)
    end
  end

  def decode
    url_decode_service = UrlDecodeService.new(@url).call

    if url_decode_service.success?
      render_json(original_url: url_decode_service.result)
    else
      render_command_service_error_json(url_decode_service)
    end
  end

  private

  def sanitize_params
    @url = ActionController::Base.helpers.sanitize(params[:url])
  end
end
