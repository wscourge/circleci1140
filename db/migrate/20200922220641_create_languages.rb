# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages, primary_key: :code, id: :lang_code, force: :cascade do |t|
      t.string :name, null: false
      t.string :native, null: false
      t.boolean :rtl, null: false, default: false
      t.boolean :active, null: false, default: false
    end

    add_index :languages, :name, unique: true
    add_index :languages, :native, unique: true
  end
end
