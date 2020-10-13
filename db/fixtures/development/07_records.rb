# frozen_string_literal: true

date = "Sun, 16 Feb 2020 22:40:55 CET +01:00".to_date

Record.bulk_insert(
  :id,
  :user_id,
  :issue_id,
  :start_time,
  :end_time,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    user_id: 1,
    issue_id: 5,
    start_time: Time.zone.parse((date - 1.week - 1.hour).to_s),
    end_time: Time.zone.parse((date - 1.week).to_s),
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    user_id: 1,
    issue_id: 7,
    start_time: Time.zone.parse((date - 3.weeks - 2.hours).to_s),
    end_time: Time.zone.parse((date - 3.weeks).to_s),
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 3,
    user_id: 1,
    issue_id: 7,
    start_time: Time.zone.parse((date - 6.weeks - 1.5.hours).to_s),
    end_time: Time.zone.parse((date - 6.weeks).to_s),
    updated_at: Time.zone.now,
    created_at: Time.zone.now
  )

  worker.add(
    id: 4,
    user_id: 1,
    issue_id: 8,
    start_time: Time.zone.parse((date - 12.weeks - 20.hours).to_s),
    end_time: Time.zone.parse((date - 12.weeks).to_s),
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 5,
    user_id: 2,
    issue_id: 6,
    start_time: Time.zone.parse((date - 16.weeks - 7.hours).to_s),
    end_time: Time.zone.parse((date - 16.weeks).to_s),
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 6,
    user_id: 2,
    issue_id: 8,
    start_time: Time.zone.parse((date - 18.weeks - 9.hours).to_s),
    end_time: Time.zone.parse((date - 18.weeks).to_s),
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end
