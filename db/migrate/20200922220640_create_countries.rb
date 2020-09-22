# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries, primary_key: :iso2, id: :iso2, force: :cascade do |t|
      t.column :iso3, :iso3
      t.integer :code, limit: 2
      t.string :name, null: false
      t.string :native, null: false
      t.integer :phonecode, limit: 2
    end

    add_index :countries, :name, unique: true
    add_index :countries, :native, unique: true
  end
end
