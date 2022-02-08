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
    if !speed.zero? # поезд не остановлен

    elsif @wagons.zero? # вагонов не осталось

    else
      @wagons -= 1
      
    end
  end

  def getting_route(route)
    @route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first

  end

  def go_to_prev_station
    if @current_station != @route.stations.first
      prev_step = @route.stations.index(@current_station) - 1
      @current_station = @route.stations[prev_step]
      @current_station.add_train(self)

    else
    end
  end

  def go_to_next_station
    if @current_station != @route.stations.last
      next_step = @route.stations.index(@current_station) + 1
      @current_station = @route.stations[next_step]
      @current_station.add_train(self)

    else
    end
  end

  def next_station
    return nil if current_station_index == @route.stations.count - 1
    @route.stations[current_station_index + 1]
  end

  def prev_station
    return nil if current_station_index.zero?
    @route.stations[current_station_index - 1]
  end


  def station_show
    current_station_index = @route.stations.index(@current_station)

    if current_station != route.stations.first
      prev_station =  @route.stations[current_station_index - 1]
    end

    if current_station != route.stations.last
      next_station =  @route.stations[current_station_index + 1]
    end
  end

  private

  def current_station_index
    @route.stations.index(@current_station)
  end

end
