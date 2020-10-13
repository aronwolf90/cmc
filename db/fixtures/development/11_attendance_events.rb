# frozen_string_literal: true

AttendanceEvent.bulk_insert(
  :id,
  :from_day,
  :to_day,
  :from_time,
  :to_time,
  :description,
  :user_id,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    from_day: "2019-01-15",
    to_day: "2019-01-16",
    from_time: "08:00",
    to_time: "17:00",
    description: "Test description",
    user_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    from_day: Date.today + 1.day,
    to_day: Date.today + 1.day,
    from_time: Time.zone.now + 1.day,
    to_time: Time.zone.now + 1.day + 10.seconds,
    description: "Test description",
    user_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end
