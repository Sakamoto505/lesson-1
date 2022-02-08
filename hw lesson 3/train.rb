# frozen_string_literal: true
require 'pry'
class Train
  attr_reader :number, :type, :wagons, :current_speed, :current_station, :route

  def initialize(number:, type:, wagons:)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
    @current_station = nil
  end

  # набор скорости
  def add_speed(speed)
    self.current_speed += speed.to_i
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
      puts 'Поезд не остановлен'
    elsif @wagons.zero? # вагонов не осталось
      puts "вагонов не осталось"
    else
      @wagons -= 1
      puts "Вагон отцеплен, осталось#{wagons} вагонов"
    end
  end

  def getting_route(route)
    @route = route
    route.stations.first.add_train(self)


    @current_station = route.stations.first

    puts "Поезд №#{@number} готов ехать с станции #{route.stations.first.name} на станцию #{@route.stations.last.name}"
  end

  def prev
    if @current_station != @route.stations.first
      prev_step = @route.stations.index(@current_station) - 1
      @current_station = @route.stations[prev_step]
      @current_station.add_train(self)

      puts "Вы вернулись на станцию #{current_station.name}"
    else
      puts 'Станция начальная'
    end
  end

  def next
    if @current_station != @route.stations.last
      next_step = @route.stations.index(@current_station) + 1
      @current_station = @route.stations[next_step]
      @current_station.add_train(self)

      puts "Вы прибыли на станцию #{current_station.name}"
    else
      puts 'Станция уже конечная'
    end
  end

  def station_show
    puts " Текущий поезд #{number} находится на станции #{current_station.name}"
    current_station_index = @route.stations.index(@current_station)

    if current_station != route.stations.first
      prev_station =  @route.stations[current_station_index - 1]

      puts "Предедущая станцией является #{prev_station.name}"
    end

    if current_station != route.stations.last
      next_station =  @route.stations[current_station_index + 1]
      puts "Следующий станцией является #{next_station.name}"
    end
  end
end
