Gem::Specification.new do |s|
  s.name        = 'simple_forecast'
  s.executables  << 'forecast'
  s.version     = "0.0.3"
  s.date        = "2013-10-27"
  s.summary     = "A simple weather forecaster"
  s.description = "A weather forecast relative to current conditions where you are.  Allows for getting the forecast for today, tomorrow, or the upcoming weekend."
  s.authors     = ["Anders Ramsay", "Joe O'Conor"]
  s.email       = ["andersr@gmail.com", "joe.oconor@gmail.com"]
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/simple-forecast/ruby-gem'
  s.license     = 'MIT'
  s.require_path = '.'
  s.add_runtime_dependency 'forecast_io', ['>= 2.0.0']
  s.add_runtime_dependency 'geocoder', ['>= 1.1.8']
  s.post_install_message = <<-MSG

  Thanks for installing Simple Forecast.  Enter 'forecast today' to get today's forecast. Enter 'forecast help' for more commands.
  
  MSG

end