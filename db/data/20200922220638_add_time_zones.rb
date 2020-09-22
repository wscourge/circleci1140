# frozen_string_literal: true

class AddTimeZones < ActiveRecord::Migration[6.0]
  def up
    TimeZone.insert_all(JSON.parse(File.read(Rails.root.join('db', 'json', 'time_zones.json'))))
  end

  def down
    TimeZone.delete_all
  end
end
