# frozen_string_literal: true

class AttendanceDay < ActiveModelSerializers::Model
  attributes :day

  def day=(day)
    @day = day.to_date
  end

  def id
    day
  end

  def self.from_to(from, to)
    (from.to_date..to.to_date).map do |day|
      new(day: day)
    end
  end

  def kind
    @kind ||=
      if day.saturday? || day.sunday?
        "weekend-day"
      elsif Holidays.on(day, :de).any?
        "holiday-day"
      else
        "normal-day"
      end
  end

  def to_s
    day.strftime("%a %d")
  end
end
