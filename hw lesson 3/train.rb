# frozen_string_literal: true

require 'pry'
class Train
  attr_reader :number, :type, :wagons, :current_speed, :current_station, :route

  def initialize(number:, type:, wagons:)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

  # набор скорости
  def add_speed(speed)
    self.current_speed += speed
  end

  # остановка
  def stop
    @current_speed = 0
  end

  # прицеплять вагоны
  def add_wagon
    @wagons += 1 if current_speed.zero?
  end

  # отцеплять вагоны
  def detach_wagon
    @wagons -= 1 if current_speed.zero? && wagons.nonzero?
  end

  def getting_route(route)
    @route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first
  end

  def go_to_prev_station
    if @current_station != @route.stations.first
      @current_station.send_train(self)
      @current_station = prev_station
      @current_station.add_train(self)

      @current_station
    end
  end

  def go_to_next_station
    if @current_station != @route.stations.last
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.add_train(self)

      @current_station
    end
  end

  def next_station
    return if current_station_index == @route.stations.count - 1

    @route.stations[current_station_index + 1]
  end

  def prev_station
    return if current_station_index.zero?

    @route.stations[current_station_index - 1]
  end

  private

  def current_station_index
    @route.stations.index(@current_station)
  end
end
