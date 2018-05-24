# frozen_string_literal: true

require 'net/http'
require 'rubygems'
require 'json'

class Malkist
  # Class Distance is a class to get Distance Matrix of coordinates. It will hit Google Maps Distance Matrix API and
  # wrap it inside Distance class based on its origin and destination.
  class Distances
    def initialize(origins, destinations)
      @origins = origins
      @destinations = destinations
    end

    # calculate_distance will hit Distance Matrix API and wrap it inside class Distance.
    def calculate_distance
      uri = URI('https://maps.googleapis.com/maps/api/distancematrix/json')

      # Google API specification stated that each params need to be seperated by '|'
      # if i do params = { origins: @origins, destinations: @destinations }
      # it will turn into origins=a&origins=b&destinations=c&destinatons=d
      # the API will only acceot the first one, so i need to create the string query manually

      uri_origins = ''

      uri_destinations = ''

      @origins.each_with_index do |origin, key|
        uri_origins += origin
        uri_origins += '|' if key != @origins.length - 1
      end

      @destinations.each_with_index do |destination, key|
        uri_destinations += destination
        uri_destinations += '|' if key != @destinations.length - 1
      end

      params = { origins: uri_origins, destinations: uri_destinations }

      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)

      # puts uri

      body = {}

      body = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)

      result = []

      body['rows'].each_with_index do |row, row_key|
        row['elements'].each_with_index do |element, key|
          dist = Distance.new(
            body['origin_addresses'][row_key],
            body['destination_addresses'][key],
            element['distance']['value'],
            element['duration']['value']
          )
          result.push(dist)
        end
      end

      result
    end

    # Distance is class to wrap the response of Distance Matrix Google API.
    class Distance
      attr_accessor :origin, :destination, :distance, :duration

      def initialize(origin, destination, distance, duration)
        @origin = origin
        @destination = destination
        @distance = distance
        @duration = duration
      end
    end
  end
end
