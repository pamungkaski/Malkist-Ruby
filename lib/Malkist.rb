# frozen_string_literal: true

require 'Malkist/version'
require 'Malkist/distances'

# Class Malkist is a class for Google Maps Service APIs wrapper. It will wrap the response into a deliverable object.
class Malkist
  def self.calculate_distance(origins, destinations)
    distance = Distances.new(origins, destinations)
    distance.calculate_distance
  end
end