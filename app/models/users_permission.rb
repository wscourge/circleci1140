# frozen_string_literal: true

class UsersPermission < ApplicationRecord
  belongs_to :user
  belongs_to :permission
end
