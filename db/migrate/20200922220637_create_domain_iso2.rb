# frozen_string_literal: true

class CreateDomainIso2 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE DOMAIN iso2 AS CITEXT NOT NULL CHECK(VALUE ~* '^[a-zA-Z]{2}$');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP DOMAIN iso2;
    SQL
  end
end
