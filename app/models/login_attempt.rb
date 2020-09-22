# frozen_string_literal: true

class LoginAttempt < ApplicationRecord
  enum status: {
    success: "success",
    failure: "failure"
  }
end
