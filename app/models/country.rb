# frozen_string_literal: true

class Country < ApplicationRecord
  self.implicit_order_column = :iso2
end
