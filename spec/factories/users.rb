FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { '00000a' }
    password_confirmation { password }
    last_name             { '杉元' }
    first_name            { '佐一' }
    kana_last_name        { 'スギモト' }
    kana_first_name       { 'サイチ' }
    date_of_birth         { '1883-03-01' }
  end
end
