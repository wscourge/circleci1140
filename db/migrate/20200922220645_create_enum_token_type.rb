# frozen_string_literal: true

class CreateEnumTokenType < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE TYPE token_type AS ENUM ('PasswordResetToken', 'EmailVerificationToken', 'AccountRecoveryToken', 'JwtRefreshToken');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP TYPE token_type;
    SQL
  end
end
