require 'forecast_io'
require 'geocoder'
require 'open-uri'

# TODO: set this gem to only be used in dev
require 'pry'

ForecastIO.api_key = '2b5cab93f5051c1207517df51d39ceee'

require_relative '../lib/models/forecast'
require_relative '../lib/models/weather_data'
require_relative '../lib/models/cli_router'
