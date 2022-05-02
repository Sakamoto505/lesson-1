# frozen_string_literal: true

require_relative './comp_name'
require_relative './instance_counter'

class Train
  include CompName
  include InstanceCounter
  attr_reader :number, :type
  attr_accessor :train_type, :wagons, :current_station, :current_speed, :route

  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}/i.freeze

  @@trains = {}

  def initialize(number)
    @number = number
    @type = type
    validate!
    @wagons = {}
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
    raise 'Приципите вагон правильного типа' unless wagon.wagon_type == train_type

    wagons[wagon.number] = wagon

    puts "Вагон #{wagon} прицеплен"
  end

  def getting_route(route)
    @route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first
    puts "Поезд №#{@number} готов ехать с станции #{route.stations.first.name} на станцию #{@route.stations.last.name}"
  end

  def go_to_prev_station
    return unless @current_station != @route.stations.first

    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.add_train(self)

    @current_station
  end

  def go_to_next_station
    return unless @current_station != @route.stations.last

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)

    @current_station
  end

  def next_station
    return if current_station_index == @route.stations.count - 1

    @route.stations[current_station_index + 1]
  end

  def prev_station
    return if current_station_index.zero?

    @route.stations[current_station_index - 1]
  end

  def pick_wagon(number)
    @wagons[number]
  end

  def list_of_wagons(&block)
    @wagons.each(&block)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise 'Неправильный формат номера. Попробуйте еще раз!' if @number !~ NUMBER_FORMAT
    raise 'Отсутвует номер' if @number.nil?
  end

  protected

  def current_station_index
    @route.stations.index(@current_station)
  end
end
