require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should belong_to(:player) }

  it { should validate_presence_of(:score) }
  it { should validate_presence_of(:time) }
end
