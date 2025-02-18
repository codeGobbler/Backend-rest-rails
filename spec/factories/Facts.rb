# frozen_string_literal: true

FactoryBot.define do
  factory :fact do
    fact_text { Faker::ChuckNorris.fact }
    likes { Faker::Number.number(digits: 3).to_i }
    association :user
  end
end
