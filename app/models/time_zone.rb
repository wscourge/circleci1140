# frozen_string_literal: true

class TimeZone < ApplicationRecord
  self.implicit_order_column = :name
end
