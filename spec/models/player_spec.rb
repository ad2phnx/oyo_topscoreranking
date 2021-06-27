require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:name).on(:create) }
  it { should have_many(:scores).dependent(:destroy) }
end
