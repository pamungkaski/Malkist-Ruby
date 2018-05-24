# frozen_string_literal: true

require 'net/http'
require 'rubygems'
require 'json'

module Malkist
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

      params = { origins: @origins.join('|'), destinations: @destinations.join('|') }

      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)

      # puts uri

      return [] unless res.is_a?(Net::HTTPSuccess)

      body = {}

      body = JSON.parse(res.body)

      result = []

      body['rows'].each_with_index do |row, row_index|
        row['elements'].each_with_index do |element, index|
          dist = Distance.new(
            body['origin_addresses'][row_index],
            body['destination_addresses'][index],
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
