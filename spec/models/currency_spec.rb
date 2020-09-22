# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currency, type: :model do
  it 'tests failures aggregation' do
    # expect(2 + 3).to eq(3)
    expect([1] + [2]).to eq([1, 2])
    # expect('A' * 13).to eq('ABC')
    expect(1 + 2).to eq(3)
  end
end
