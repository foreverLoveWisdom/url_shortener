# frozen_string_literal: true

class CreateShortenedUrl < ActiveRecord::Migration[7.0]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url, null: false
      t.string :short_url, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
