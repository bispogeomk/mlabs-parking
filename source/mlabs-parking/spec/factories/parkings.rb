FactoryBot.define do
  factory :parking do
    plate { "AAA-9876" }
    car_in { "2019-10-18 03:58:24" }
    car_out { "2019-10-18 03:59:24" }
    paid { false }
  end
end
