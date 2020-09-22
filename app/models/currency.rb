# frozen_string_literal: true

class Currency < ApplicationRecord
  self.implicit_order_column = :iso3
end
