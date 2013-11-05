class WeatherData

1383537600
  attr_accessor :yesterday_data, :today_data, :lat, :long

  NYC = [40.714623, -74.006605]
  NYC_LAT = NYC[0]
  NYC_LONG = NYC[1] 

  def initialize(lat = NYC.first, long = NYC.last)
    @lat = lat
    @long = long
    print '.'
    @today_data = ForecastIO.forecast(self.lat, self.long) 
    # when you don't specify a time in the ForecastIO call, you can get the daily high temps
  end

  def yesterday_temp
    print '.'
    @yesterday_data = ForecastIO.forecast(self.lat, self.long, time: time_yesterday)
    self.yesterday_data["daily"]["data"].first["temperatureMax"]
  end

  def last_night_temp
    print '.'
    @yesterday_data = ForecastIO.forecast(self.lat, self.long, time: time_yesterday)
    yesterday_temp_10_pm
  end

  def yesterday_temp_10_pm
    self.yesterday_data["hourly"]["data"].each do |hour_entry|
      return hour_entry["temperature"] if Time.at(hour_entry["time"]).hour == 22
    end
  end

  def today_temp
    self.today_data["daily"]["data"].first["temperatureMax"]
  end

  def today_summary
    self.today_data["daily"]["data"][0]["summary"].downcase.gsub(/\./,'')
  end


  def tonight_temp
    today_temp_10_pm
  end

  def today_temp_10_pm
    if Time.now.hour >= 22
      return self.today_data["currently"]["temperature"]
    end
    self.today_data["hourly"]["data"].each do |hour_entry|
      return hour_entry["temperature"] if Time.at(hour_entry["time"]).hour == 22
    end
  end

  def tomorrow_temp
    self.today_data["daily"]["data"][1]["temperatureMax"]
  end

  def tomorrow_summary
    self.today_data["daily"]["data"][1]["summary"].downcase.gsub(/\./,'')
  end

  def tomorrow_night_temp
    if Time.now.hour >= 22
      start = 0
    else
      start = 24
    end

    self.today_data["hourly"]["data"][start..-1].each do |hour_entry|
      return hour_entry["temperature"] if Time.at(hour_entry["time"]).hour == 22
    end
  end

  def time_yesterday
    Time.now.to_i - 86400
  end

end
