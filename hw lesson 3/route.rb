# frozen_string_literal: true

class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    if station == stations.first

    elsif station == stations.last

    else
      stations.delete(station)

    end
  end
end
