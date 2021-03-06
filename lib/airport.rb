require_relative 'plane'
require 'set'

class Airport

  DEFAULT_CAPACITY = 10
  attr_reader :hanger
  attr_reader :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @hanger = Set.new []
    @capacity = capacity
  end

  def request_landing(plane)
    raise "Plane has already landed!" if plane_exist?(plane)
    raise "Airport is full, unable to land" if full?
    bad_weather_check
    plane.land
    dock_plane(plane)
  end

  def request_take_off(plane)
    raise "Plane does not exist in hanger!" unless plane_exist?(plane)
    bad_weather_check
    plane.take_off
    delete_from_hanger(plane)
  end

  private

  def full?
    @hanger.size >= @capacity
  end

  def random_weather_gen
    rand(0..100)
  end

  def raise_bad_weather
    raise "bad weather alert"
  end

  def bad_weather_check
    random_weather_gen < 10 ? raise_bad_weather : nil
  end

  def dock_plane(plane)
    @hanger.add(plane)
  end

  def plane_exist?(plane)
    @hanger.include?(plane)
  end

  def delete_from_hanger(plane)
    @hanger.delete?(plane)
  end

end
