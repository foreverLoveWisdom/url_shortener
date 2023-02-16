# frozen_string_literal: true

Rails.application.routes.draw do
  post '/encode', to: 'shortened_url#encode'
  get '/decode', to: 'shortened_url#decode'
end
