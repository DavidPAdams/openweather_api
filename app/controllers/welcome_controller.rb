class WelcomeController < ApplicationController
  def test
  	response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=85004&units=imperial&appid=#{ENV['openweather_api_key']}")
    @location = response['name']
    @temp = response['main']['temp']
    @feels_like = response['main']['feels_like']
    @humidity = response['main']['humidity']
    @weather_icon = response['weather'][0]['icon']
    @weather_words = response['weather'][0]['description']
    @cloudiness = response['clouds']['all']
    @windiness = response['wind']['speed']
  end

  def index
  	    # checks that the zipcode param is not empty before calling the API
    if params[:zipcode] != '' && !params[:zipcode].nil?
      response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=#{params[:zipcode]}&units=imperial&appid=#{ENV['openweather_api_key']}")
      @status = response['cod']
      # if no error is returned from the call, we fill our instance variables with the result of the call
      if @status != '404' && response['message'] != 'city not found'
        @location = response['name']
        @temp = response['main']['temp']
        @weather_icon = response['weather'][0]['icon']
        @weather_words = response['weather'][0]['description']
        @cloudiness = response['clouds']['all']
        @windiness = response['wind']['speed']
      else
        # if there is an error, we report it to our user via the @error variable
        @error = response['message']
      end
    end
  end
end
