# frozen_string_literal: true

class Route
  attr_accessor :stations

  def initialize(first, last)
    if first == last
      puts 'Начальная и конечная станция одинаковы! Будьте внимательны'
    else
      @stations = [first, last]
    end
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    if station == stations.first
      puts 'Первая'

    elsif station == stations.last

      puts 'Последняя'
    else
      stations.delete(station)
    end
  end

  def show_stations
    puts stations
  end
end
