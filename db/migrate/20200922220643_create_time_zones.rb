# frozen_string_literal: true
# https://timezonedb.com/download
class CreateTimeZones < ActiveRecord::Migration[6.0]
  def change
    create_table :time_zones, id: :uuid do |t|
      t.column :country_iso2, :iso2, null: false, foreign_key: { name: :time_zones_countries_iso2 }
      t.string :abbreviation, limit: 6, null: false
      t.string :name, null: false
      t.decimal :time_start, scale: 0, precision: 11, null: false
      t.integer :gmt_offset, limit: 3, null: false
    end

    add_index :time_zones, :name, unique: true
  end
end
