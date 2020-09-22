# frozen_string_literal: true

class CreateLoginAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :login_attempts, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, foreign_key: { name: :login_attempts_users_id }
      t.column :status, :login_attempt_status, null: false
      t.inet :ip, null: false
      # varies for different JWT audiences (payload.aud)
      # browser:
      # { user_agent, referrer }
      # mobile
      # { os, version, device_name, device_year, ios_device_model }
      t.jsonb :metadata, null: false
      t.datetime :created_at, null: false
    end
  end
end
