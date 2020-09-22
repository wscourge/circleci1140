# frozen_string_literal: true

class CreateDomainEmail < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE DOMAIN email AS CITEXT NOT NULL CHECK(VALUE ~* '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP DOMAIN email;
    SQL
  end
end
