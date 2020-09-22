# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :users_permissions
end
