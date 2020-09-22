# frozen_string_literal: true

class CreateUsersPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :users_permissions, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: { name: :users_permissions_users_id }
      t.belongs_to :permission, type: :uuid, null: false, foreign_key: { name: :users_permissions_permissions_id }
    end
  end
end
