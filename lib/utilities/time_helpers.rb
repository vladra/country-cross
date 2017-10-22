module Utilities
  class TimeHelpers
    REGEX = /((?<hr>\d{1,2}):)?(?<min>\d{1,2}):(?<sec>\d{2})\.|\,(?<ms>\d{2,3})/.freeze

    def time_to_ms(time)
      match = time.match(REGEX)

      hr = match[:hr] && match[:hr].to_i || 0
      min = match[:min].to_i
      sec = match[:sec].to_i
      ms = match[:ms].to_i

      ms + sec * 1000 + min * 60 * 1000 + hr * 60 * 60 * 1000
    end

    def ms_to_time(ms)
      usec = ms % 1000
      seconds = ms / 1000

      Time.at(seconds).strftime("%M:%S.#{usec}")
    end
  end
end
