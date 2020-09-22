# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
    end

    add_index :permissions, :slug, unique: true
    add_index :permissions, :name, unique: true
  end
end
