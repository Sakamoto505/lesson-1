# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :stations
  attr_accessor :name

  def initialize(stations = [])
    @stations = stations
    validate!
  end

  def name_route(name)
    @name = name
  end

  def add_station(station)
    if stations.include? station
      puts 'Станция уже добавлена'
    else
      stations.insert(-2, station)
      puts "Станция #{station.name} добавлена в маршрут #{name}"
    end
  end

  def delete_station(station)
    stations.delete(station)
    puts "Станция #{station.name} удалена "
  end

  def list
    names = []
    stations.each do |index|
      names << index.name
    end
    names
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise 'Маршрут должен состоять больше двух станций' if stations.size < 2
    raise 'Начальная и конечная не должны совпадать' if @stations.first == @stations.last
  end
end
