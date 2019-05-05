# frozen_string_literal: true

FactoryBot.define do
  factory :attendance_event do
    user { create(:employee) }
    from_day { "2019-05-03" }
    to_day { "2019-05-03" }
    from_time { "2019-05-03 20:03:08" }
    to_time { "2019-05-03 20:03:08" }
  end
end
