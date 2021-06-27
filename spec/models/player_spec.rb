require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many(:scores).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
