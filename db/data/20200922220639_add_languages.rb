# frozen_string_literal: true

class AddLanguages < ActiveRecord::Migration[6.0]
  def up
    Language.insert_all(JSON.parse(File.read(Rails.root.join('db', 'json', 'languages.json'))))
  end

  def down
    Languages.delete_all
  end
end
