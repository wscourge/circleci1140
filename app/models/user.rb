# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :users_permissions, dependent: :destroy
  has_many :permissions, through: :users_permissions, dependent: :destroy
end
