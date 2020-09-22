# frozen_string_literal: true

class AddCountries < ActiveRecord::Migration[6.0]
  def up
    Country.insert_all(JSON.parse(File.read(Rails.root.join('db', 'json', 'countries.json'))))
  end

  def down
    Country.delete_all
  end
end
