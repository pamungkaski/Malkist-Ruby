# frozen_string_literal: true

require_relative('malkist/distances')

# Module malkist is a module for Google Maps Service APIs wrapper. It will wrap the response into a deliverable object.
module Malkist
  def self.calculate_distance(origins, destinations)
    distance = Distances.new(origins, destinations)
    distance.calculate_distance
  end
end
