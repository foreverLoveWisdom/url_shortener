# frozen_string_literal: true

# Base API controller
class ApplicationController < ActionController::API
  # Renders the given data as a JSON object.
  #
  # @param data [Object] The data to be rendered as JSON.
  #
  # @return [String] The JSON object as a string.
  #
  # Example
  #
  #   my_data = { short_url: "http://short.est/abc6de" }
  #   render_json(my_data)
  #=> "{ \"short_url\": \"http://short.est/abc6de\" }"
  # @note Can put all data in a data key to make it easier to add more data later
  def render_json(data)
    render json: data
  end

  # Renders a command service error as a JSON response.
  #
  # @param command_service [Object] A command service object.
  # @param http_status_code [Integer] The HTTP status code (defaults to 422).
  #
  # @return [String] A JSON response containing an array of errors.
  #
  # Example:
  #   render_command_service_error_json(some_command_service)
  #=> "{\"errors\":[{\"detail\":\"Some error message."}]\"
  def render_command_service_error_json(command_service, http_status_code = 422)
    render json: { errors: [{ detail: command_service_error(command_service) }] }, status: http_status_code
  end

  private

  def command_service_error(command_service)
    command_service.errors.full_messages.to_sentence
  end
end
