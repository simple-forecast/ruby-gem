class CLIRouter

  attr_reader :weather_forecast, :commands

  APPROVED_COMMANDS = ["help","today","tomorrow","weekend", "tonight", "tomorrow_night"]

  def initialize(commands)
    @commands = commands # in fact this is ARGV

    if commands.length == 0
      puts "Please enter something like 'forecast tomorrow' or enter 'forecast help' to learn more."
    elsif commands.include?("help")
      help
    else
      parse_commands
    end
  end
 
  def collect_weather_data
    get_user_location
    set_forecast_location
    wd = WeatherData.new(@forecast_location.first, @forecast_location.last)
    @weather_forecast = Forecast.new(wd)
  end

  def get_user_location
    @longitude_latitude = Geocoder.coordinates(open('http://whatismyip.akamai.com').read)
  end

  def set_forecast_location
    #based on idea that location would live in second slot

    #if other location false, use current location
    @forecast_location = Geocoder.coordinates(commands[1]) || @longitude_latitude
  end

  def help
    # TODO: rewrite with more detailed help block
    #puts weather_forecast.today
    #puts weather_forecast.separator
    puts <<-TEXT

    Thanks for using Simple Forecast. Currently, the following commands are supported:

    help        Displays help (what you're viewing now)
    today       Today's forecast (compared to yesterday)
    tonight     Tonight's forecast (10pm compared to 10pm last night)
    tomorrow    Tomorrow's forecast (compared to today)
    tomorrow_night   Tomorrow night's forecast (compared to 10pm tonight)
    weekend     Average temperature for this weekend (compared to today) 

    TEXT
  end

  def parse_commands
    #binding.pry
    if commands.length == 1 && APPROVED_COMMANDS.include?(commands[0])
      collect_weather_data
      puts weather_forecast.send(self.commands[0])
    else
      puts "Sorry, not sure what you're asking for, please enter 'forecast help' to learn more."
    end
  end

end

