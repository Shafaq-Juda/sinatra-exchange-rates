require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "better_errors"

# Need this configuration for better_errors
use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')


get("/") do

  # building the API url, including the API key in the query string
  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "http://api.exchangerate.host/list?access_key="+ exchange_rate_key

  # using HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # converting the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to hash with JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON to fetch the required key
   @symbols = parsed_data

   @currency = @symbols.fetch("currencies")
   @currency_key = @currency.keys


  # render a view template where I show the symbols
  erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "http://api.exchangerate.host/list?access_key="+ exchange_rate_key
  
  # some more code to parse the URL and render a view template
  
  # using HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # converting the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

   # get the from from the JSON
   @to_currency = parsed_data

  # render a view template where I show the from
  erb(:from_currency)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "https://api.exchangerate.host/convert?access_key="+ exchange_rate_key + "&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  # some more code to parse the URL and render a view template

   # using HTTP.get to retrieve the API information
   raw_data = HTTP.get(api_url)

   # converting the raw request to a string
   raw_data_string = raw_data.to_s
 
   # convert the string to JSON
   parsed_data = JSON.parse(raw_data_string)
 
    # get the to from the JSON
    @to = parsed_data
 
   # render a view template where I show the to
   erb(:to_currency)
end


get("/<% one %>")do
@original_currency = params.fetch("from_currency")
@destination_currency = params.fetch("to_currency")

exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
api_url = "http://api.exchangerate.host/list?access_key="+ exchange_rate_key

# some more code to parse the URL and render a view template
# using HTTP.get to retrieve the API information
raw_data = HTTP.get(api_url)

# converting the raw request to a string
raw_data_string = raw_data.to_s

# convert the string to JSON
parsed_data = JSON.parse(raw_data_string)

 # get the from from the JSON
 @to_currency = parsed_data

 @to_currency_keys = @to_currency.class
  # @to_currency = @to_currency.keys


# render a view template where I show the from
  erb(:from_currency)
end
