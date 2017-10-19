class TimeCalculator
  def time_to_ms(time)
  end

  def ms_to_time(ms)
    usec = ms % 1000
    seconds = ms / 1000

    Time.at(seconds).strftime("%M:%S.#{usec}")
  end
end
