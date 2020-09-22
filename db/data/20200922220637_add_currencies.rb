# frozen_string_literal: true

require 'json'

class AddCurrencies < ActiveRecord::Migration[6.0]
  def up
    Currency.insert_all(JSON.parse(File.read(Rails.root.join('db', 'json', 'currencies.json'))))
  end

  def down
    Currency.delete_all
  end
end
