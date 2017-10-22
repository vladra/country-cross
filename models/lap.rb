require_relative '../lib/utilities/time_helpers'

class Lap < Sequel::Model
  many_to_one :racer
  many_to_one :stage

  def time=(t)
    case t
    when String then Utilities::TimeHelpers.new.time_to_ms(t)
    else super(t)
    end
  end

  def h_time
    Utilities::TimeHelpers.new.ms_to_time(time)
  end
end
