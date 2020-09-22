# frozen_string_literal: true

class Language < ApplicationRecord
  self.implicit_order_column = :code
end
