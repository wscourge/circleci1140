# frozen_string_literal: true

class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies, primary_key: :iso3, id: :iso3, force: :cascade do |t|
      t.string :name, limit: 30
      t.string :symbol, limit: 10
      t.boolean :active, null: false, default: false
    end
  end
end
