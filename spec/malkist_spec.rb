# frozen_string_literal: true

RSpec.describe Malkist do
  it 'has a version number' do
    expect(Malkist::VERSION).not_to be nil
  end

  it 'return distance between two coordinate' do
    result = Malkist.calculate_distance(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592])
    expect(result[0].distance).to eq(10423)
  end

  it 'return distance between one origin with many destinations' do
    result = Malkist.calculate_distance(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    result = Malkist.calculate_distance(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592])
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    result = Malkist.calculate_distance(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(9)
  end
end

RSpec.describe Malkist::Distances do
  it 'return distance between two coordinate' do
    distances = Malkist::Distances.new(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592])
    result = distances.calculate_distance
    expect(result[0].distance).to eq(10423)
  end

  it 'return distance between one origin with many destinations' do
    distances = Malkist::Distances.new(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    result = distances.calculate_distance
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    distances = Malkist::Distances.new(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592])
    result = distances.calculate_distance
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    distances = Malkist::Distances.new(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    result = distances.calculate_distance
    expect(result[0].distance).to eq(10423)
    expect(result.length).to eq(9)
  end
end

RSpec.describe Malkist::Distances::Distance do
  it 'return the assigned value upon initialization' do
    distance = Malkist::Distances::Distance.new('oRigiNaslz Addrewses', 'dWesttwinattizion Addrewses', 65123, 1235123)
    expect(distance.origin).to eq('oRigiNaslz Addrewses')
    expect(distance.destination).to eq('dWesttwinattizion Addrewses')
    expect(distance.distance).to eq(65123)
    expect(distance.duration).to eq(1235123)
  end
end