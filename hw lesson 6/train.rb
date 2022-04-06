# frozen_string_literal: true
require_relative "./comp_name.rb"
require_relative "./instance_counter.rb"

class Train
  include CompName
  include InstanceCounter
  attr_reader :number, :type
  attr_accessor :train_type, :wagons, :current_station, :current_speed, :route
  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i

  @@trains = {}

  def initialize(number)
    @number = number
    @type = type
    validate!
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
  end

  def self.find(number)
    if @@trains[number].nil?
      puts "Поезд с номером #{@number} не найден, nil"
    else
      @@trains[number]
    end
  end

  def add_speed(speed)
    self.current_speed += speed
  end

  def stop
    @current_speed = 0
  end

  def remove_wagon
    wagons.delete(-1) unless wagons.empty?
  end

  def add_wagon(wagon)
    if wagon.wagon_type == train_type
      wagons << wagon

      puts "Вагон #{wagon} прицеплен"
    else
      puts 'Приципите вагон правильного типа'
    end
  end

  def getting_route(route)
    @route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first
    puts "Поезд №#{@number} готов ехать с станции #{route.stations.first.name} на станцию #{@route.stations.last.name}"
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

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "Неправильный формат номера. Попробуйте еще раз!" if @number !~ NUMBER_FORMAT
    raise "Отсутвует номер" if @number.nil?
  end

  protected

  def current_station_index
    @route.stations.index(@current_station)
  end
end
