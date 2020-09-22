# frozen_string_literal: true

class CreateDomainIso3 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE DOMAIN iso3 AS CITEXT NOT NULL CHECK(VALUE ~* '^[a-zA-Z]{3}$');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP DOMAIN iso3;
    SQL
  end
end
