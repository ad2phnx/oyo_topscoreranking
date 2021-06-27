# spec/factories/players.rb
FactoryBot.define do
    factory :player do
        name { Faker::Movies::StarWars.character }
    end
end