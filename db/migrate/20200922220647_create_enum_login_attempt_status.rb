# frozen_string_literal: true

class CreateEnumLoginAttemptStatus < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE TYPE login_attempt_status AS ENUM ('success', 'failure');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP TYPE login_attempt_status;
    SQL
  end
end
