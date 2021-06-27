# spec/factories/scores.rb
FactoryBot.define do
    factory :score do
        score { Faker::Number.within(range: 1..100) }
        time { Faker::Date.in_date_period }
        player_id nil
    end
end
        