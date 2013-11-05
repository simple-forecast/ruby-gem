class Forecast

  attr_accessor :today_temp, :tonight_temp, :yesterday_temp, :last_night_temp, :tomorrow_temp, :tomorrow_night_temp, :weather_data, :compare_loc

  def initialize(weather_data_object)
    @weather_data = weather_data_object
    @today_temp = self.weather_data.today_temp
    @tomorrow_temp = self.weather_data.tomorrow_temp
    @tonight_temp = self.weather_data.tonight_temp
    @tomorrow_night_temp = self.weather_data.tomorrow_night_temp
  end

  def today
    @yesterday_temp = self.weather_data.yesterday_temp
    separator + 
    "#{compare(today_temp, yesterday_temp)}yesterday, #{self.weather_data.today_summary}"
  end

  # TODO: should the time-specific forecasts consider the 'apparentTemperature' or the 'temperature'?
  def tonight
    @last_night_temp = self.weather_data.last_night_temp
    separator +
    compare(tonight_temp, last_night_temp) + "last night"
  end

  def tomorrow
    separator +
    "#{compare(tomorrow_temp, today_temp)}today, #{self.weather_data.tomorrow_summary}"
  end

  def tomorrow_night
    separator + 
    compare(tomorrow_night_temp, tonight_temp) + "tonight"
  end


  def weekend
    separator +
    "this weekend will be " + 
    compare(avg_temp_this_weekend, today_temp) + "today"
  end

  def next_week
    # TODO: compare(this_week_avg, today)
  end
  
  def avg_temp_this_weekend
    data = find_weekend_data
    weekend_avg = (data[0]["temperatureMax"] + data[1]["temperatureMax"])/2
  end

  def find_weekend_data
    weekend_data = weather_data.today_data["daily"]["data"][1..7].select do |data_hash|
      ruby_datetime = Time.at(data_hash["time"])
      ruby_datetime.saturday? || ruby_datetime.sunday?
    end
  end

  def avg_temp_this_week

  end

  def avg_temp_next_week
  end

  def find_week_time
    week_data = weather_data.today_data["daily"]["data"][1..7].reject do |data_hash|
      ruby_datetime = Time.at(data_hash["time"])
      ruby_datetime.saturday? || ruby_datetime.sunday?
    end
    pp week_data
    week_data
  end

  def compare(temp1, temp2)
    diff = (temp1.round-temp2.round).abs

    case diff
    when (0..2)
      temp1 = temp2
    when (3..6)
      mod = "slightly "
    when (7..11)
      mod = "somewhat "
    when (12..30)
      mod = "much "
    else
      mod = ''
    end

    if temp1 == temp2
      "about the same as "
    elsif temp1 < temp2
      mod + "colder than "
    else
      mod + "warmer than "
    end
  end

  def separator
    "\n"
  end

end

