# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = 'type'
  self.implicit_order_column = 'created_at'
  UUID_FORMAT = '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
  UUID_REGEXP = /\A#{UUID_FORMAT}\z/.freeze
  EMAIL_REGEXP = URI::MailTo::EMAIL_REGEXP.freeze
  ISO_2_REGEXP = /[a-zA-Z]{2}/i.freeze
  ISO_3_REGEXP = /[a-zA-Z]{3}/i.freeze
  DB_DATE_REGEXP = /\A(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\.\d+([+-][0-2]\d:[0-5]\d|Z))|(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d([+-][0-2]\d:[0-5]\d|Z))|(\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d([+-][0-2]\d:[0-5]\d|Z))\z/.freeze
  UNACCEPTABLE_CHARACTERS = '!@#$%^&*_=+<>/{}~`'
  NO_UNSAFE_CHARACTERS = /\A((?![#{UNACCEPTABLE_CHARACTERS}]).)*\z/.freeze

  public_constant :EMAIL_REGEXP
  public_constant :UUID_REGEXP
  public_constant :UUID_FORMAT
  public_constant :DB_DATE_REGEXP
  public_constant :NO_UNSAFE_CHARACTERS
  private_constant :UNACCEPTABLE_CHARACTERS
end
