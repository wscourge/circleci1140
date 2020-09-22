# frozen_string_literal: true

class Token < ApplicationRecord
  self.implicit_order_column = :issued_at

  belongs_to :user

  def inactive?
    used_at.present? || expired_at < Time.current.getutc
  end
end
