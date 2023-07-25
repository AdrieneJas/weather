class HomeController < ApplicationController
  def index
      require 'net/http'
      require 'json'
    if params[:city].present?
      city_name = params[:city].strip
      encoded_city_name = URI.encode_www_form_component(city_name)
      weather_url = "https://api.openweathermap.org/data/2.5/weather?q=#{encoded_city_name}&units=metric&appid=58e7c2ca8326f950887a3f92875a25ee"
      weather_uri = URI(weather_url)
      weather_response = Net::HTTP.get(weather_uri)
      @weather_data = JSON.parse(weather_response)

       if @weather_data['cod'] == '404'
        @error_message = "Nie znaleziono miasta: #{city_name}"
        @weather_data = nil
      end
    end

    if @weather_data&.empty?
      @error_message ||= "Hey you forgot to enter a city name!"
      @weather_data = nil
    end
  end
end