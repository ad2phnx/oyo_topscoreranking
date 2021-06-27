# spec/factories/scores.rb
FactoryBot.define do
    factory :score do
        score { Faker::Number.positive }
        time { Faker::in_date_period }
        player_id nil
    end
end
        