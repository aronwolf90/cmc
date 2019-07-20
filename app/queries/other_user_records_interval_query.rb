# frozen_string_literal: true

class OtherUserRecordsIntervalQuery < ApplicationQuery
  pattr_initialize %i[user! start_time! end_time! record_id!]

  def call
    RecordsIntervalQuery.call(
      user.records.all_except(record_id),
      start_time: start_time,
      end_time: end_time
    )
  end
end
