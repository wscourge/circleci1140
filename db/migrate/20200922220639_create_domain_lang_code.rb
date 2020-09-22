# frozen_string_literal: true

class CreateDomainLangCode < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
      CREATE DOMAIN lang_code AS CITEXT NOT NULL CHECK(VALUE ~* '^[a-zA-Z]{2,5}$');
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP DOMAIN lang_code;
    SQL
  end
end
