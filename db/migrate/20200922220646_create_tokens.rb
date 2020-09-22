# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens, id: :uuid do |t|
      # JWT jti
      t.belongs_to :user, type: :uuid, null: false, foreign_key: { name: :tokens_users_id }
      t.column :type, :token_type, null: false
      t.inet :creation_ip
      t.inet :usage_ip
      # JWT iat
      t.datetime :issued_at, null: false
      # JWT exp
      t.datetime :expired_at, null: false
      t.datetime :used_at
    end
  end
end
