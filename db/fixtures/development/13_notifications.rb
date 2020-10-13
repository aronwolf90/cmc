# frozen_string_literal: true

Notification.bulk_insert(
  :id,
  :subject,
  :body,
  :user_id,
  :created_at,
  :updated_at
) do |worker|
  17.times do |n|
    worker.add(
      id: n + 1,
      subject: "Nofification #{n+1}",
      body: "body #{n+1}",
      user_id: 1,
      created_at: Time.zone.parse("2020-02-11T22:01:54.824+01:00"),
      updated_at: Time.zone.parse("2020-02-11T22:01:54.824+01:00")
    )
  end
end
