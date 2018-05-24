# frozen_string_literal: true

RSpec.describe Malkist do
  it 'has a version number' do
    expect(Malkist::VERSION).not_to be nil
  end

  it 'return distance between two coordinate' do
    malkist = Malkist
    result = malkist.calculate_distance(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592])
    expect(result[0].distance).to eq(10_423)
  end

  it 'return distance between one origin with many destinations' do
    malkist = Malkist
    result = malkist.calculate_distance(%w[40.6655101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    expect(result[0].distance).to eq(10_423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    malkist = Malkist
    result = malkist.calculate_distance(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592])
    expect(result[0].distance).to eq(10_423)
    expect(result.length).to eq(3)
  end

  it 'return distance between many origin with one destinations' do
    malkist = Malkist
    result = malkist.calculate_distance(%w[40.6655101,-73.89188969999998 40.6855101,-73.89188969999998 40.6255101,-73.89188969999998], %w[40.6905615,-73.9976592 40.8905615,-73.9976592 40.7905615,-73.9976592])
    expect(result[0].distance).to eq(10_423)
    expect(result.length).to eq(9)
  end
end
