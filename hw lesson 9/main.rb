# frozen_string_literal: true

require_relative 'train'
require_relative 'modules/validation'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'wagon'
require 'pry'

class Main
  def initialize
    @stations = []
    @trains = {}
    @routes = {}
  end

  def go
    loop do
      puts 'Выберите действие'
      puts '1 Действие с поездами'
      puts '2 Действие со станциями'
      puts '3 Действие с  маршрутами'
      puts '4 Вся доступная информация'
      puts '5 Создать тестовые данные'

      id = gets.chomp.to_i
      case id
      when 1 then trains_menu
      when 2 then station_menu
      when 3 then routes_menu
      when 4 then stations_info
      when 5 then seeds
      else
        exit
      end
    rescue RuntimeError => e
      puts e.message.to_s
      retry
    end
  end

  private # Все возможности работы с кодом реализованы через метод "go"

  def add_name(train)
    puts 'Введите Название компании'
    name = gets.chomp.to_i
    train.add_name(name)
  end

  def go_to_next_station(train)
    train.go_to_next_station
  end

  def go_to_prev_station(train)
    train.go_to_prev_station
  end

  def routes_menu
    if @stations.count > 1
      loop do
        puts 'Введите желаемое действие'
        puts '1 Создать маршрут'
        puts '2 Выбрать маршрут'

        id = gets.chomp.to_i
        case id
        when 1 then create_route
        when 2
          if @routes.any?
            route_list
            route = gets.chomp.to_s
            route_menu(@routes[route])
          else
            'Маршрутов нет'
          end
        else
          break
        end
      end
    else
      puts 'Для создания маршрута нужно минимум две станции'
    end
  end

  def route_list
    @routes.each do |index, value|
      puts " id #{index} #{value.stations}"
    end
  end

  def getting_route(train)
    puts "Выбран поезд #{train}"
    puts 'Введите номер маршрута'
    route_name = gets.chomp.to_s
    route_value = @routes[route_name]
    binding.pry
    @trains[train.number].getting_route(route_value)
  end

  def route_menu(route)
    loop do
      puts "1 Добавить станцию в маршруте #{route} "
      puts "2 Удалить станцию в маршруте #{route} "
      act = gets.chomp.to_i
      case act
      when 1 then add_station(route)
      when 2 then remove_station(route)
      else
        break
      end
    end
  end

  def add_station(route)
    puts 'Выберете станцию'
    stations_list
    stations_id = gets.chomp.to_i
    route.add_station(@stations[stations_id])
  end

  def remove_station(route)
    puts 'Выберите станцию'
    puts route.list

    stations_id = gets.chomp.to_i
    route.delete_station(@stations[stations_id])
  end

  def station_menu
    loop do
      puts '1 Cоздать станцию'
      puts '2 Список  станций'
      act = gets.chomp.to_i
      case act
      when 1 then create_station
      when 2 then stations_list
      else
        break
      end
    end
  end

  def create_station
    puts 'Введите название станции'
    name = gets.chomp.to_s
    s = Station.new(name)
    @stations << s
    puts "Станция #{name} создана "
  end

  def create_route
    puts 'Введите id станций,минимум две станции через запятую'
    stations_list
    stations_ids = gets.chomp.split(',')
    route_stations = []
    @stations.each_with_index do |value, index|
      stations_ids.each do |station_id|
        route_stations << value if index == station_id.to_i
      end
    end

    stations_ids = stations_ids.join('')
    @routes[stations_ids] = Route.new(route_stations)
  end

  def stations_list
    if @stations.any?
      @stations.each_with_index do |value, index|
        puts "id = #{index}  --- #{value.name} на станции находятся поезда: #{value.trains}"
      end
    else
      puts 'Станций нет!'
    end
  end

  def remove_wagons(train)
    train.remove_wagon
    puts 'Вагон отсоединен'
  end

  def add_wagons(train)
    puts "Ваш поезд #{train} типа"
    puts 'Какой вагон Присоеденить'
    puts '1 - Грузовой'
    puts '2 - Пасажирский '

    wagon_type = gets.chomp.to_i
    puts 'Укажите номер вагона'
    wagon_number = gets.chomp.to_i
    if wagon_type == 1 #----------------------------------------------
      puts 'Укажите объем'
      volume = gets.chomp.to_i
      wagon = WagonCargo.new(wagon_number, volume)
    else
      puts 'Укажите количество мест'
      seats = gets.chomp.to_i
      wagon = WagonPassenger.new(wagon_number, seats)
    end

    puts wagon
    train.add_wagon(wagon)
  end

  def train_menu(train)
    loop do
      puts "Выбран поезд #{train}"
      puts '1 Добавить вагон'
      puts '2 Удалить вагон'
      puts '3 Добавить Маршрут'
      puts '4 Вперед по маршруту'
      puts '5 Назад по маршруту'
      puts '6 Назначить название компании изготовителя'
      puts '7 Работа с вагонами'
      act = gets.chomp.to_i
      case act
      when 1 then  add_wagons(train)
      when 2 then  remove_wagons(train)
      when 3 then getting_route(train)
      when 4 then next_station(train)
      when 5 then prev_station(train)
      when 6 then add_name(train)
      when 7 then occupy_wagon(train)
      else
        break
      end
    end
  end

  def stations_info
    @stations.each do |station|
      station.trains_list do |train|
        puts "Поезд: #{train.number}, Тип: #{train.train_type}"
        if train.instance_of?(PassengerTrain)
          train.list_of_wagons do |wagon|
            puts "Вагон номер #{wagon.number}, тип: пассажирский,свободно #{wagon.free_seats}мест, занято #{wagon.taken_place} мест"
          end
        elsif train.instance_of?(CargoTrain)
          train.list_of_wagons do |wagon|
            puts "Вагон номер #{wagon.number}, тип: грузовой, свободно  #{wagon.free_volume} тонн, занято #{wagon.taken_volume} тонн"
          end
        end
      end
    end
  end

  def seeds
    train_1 = CargoTrain.new('qqq-qq')
    wagon_1 = WagonCargo.new(1, 10)
    train_1.add_wagon(wagon_1)

    train_2 = PassengerTrain.new('qqq-aa')
    wagon_2 = WagonPassenger.new(1, 10)
    train_2.add_wagon(wagon_2)

    station_1 = Station.new('first_station')
    station_2 = Station.new('second_station')
    @stations += [station_1, station_2]
    route = Route.new([station_1, station_2])
    train_1.getting_route(route)
    train_2.getting_route(route)
    puts 'Тестовые данные созданы'
  end

  def occupy_wagon(train)
    puts 'Выберите вагон для работы'
    train.list_of_wagons do |_key, wagon|
      puts wagon.number
    end

    wagon_number = gets.chomp.to_i
    wagon = train.pick_wagon(wagon_number)
    if wagon.wagon_type == :passenger
      passenger_wagon_menu(wagon)
    else
      cargo_wagon_menu(wagon)
    end
  rescue RuntimeError => e
    puts e.message.to_s
    retry
  end

  def cargo_wagon_menu(wagon)
    puts "Вагон №#{wagon.number}. Свободный объем: #{wagon.free_volume}"
    puts 'Введите объем загрузки для вагона'
    volume = gets.chomp.to_i
    wagon.take_volume(volume)
  rescue StandardError => e
    puts e.message.to_s
  end

  def passenger_wagon_menu(wagon)
    puts "Вагон №#{wagon.number}. Свободных мест: #{wagon.free_seats}"
    puts 'Введите количество мест для заполнения'
    seats = gets.chomp.to_i
    wagon.take_place(seats)
    puts "Занято 1 место в вагоне №#{wagon.number}. Свободных мест: #{wagon.free_seats}"
  rescue StandardError => e
    puts e.message.to_s
  end

  def create_train
    loop do
      puts 'Какой поезд создать?'
      puts '1. Грузовой,'
      puts '2. Пасажирский'
      train_type = gets.chomp.to_i

      case train_type
      when 1
        puts 'Введите номер поезда'
        train_number = gets.chomp
        create_cargo_train(train_number)
      when 2
        puts 'Введите номер поезда'
        train_number = gets.chomp
        create_passenger_train(train_number)

      else
        break
      end
    end
  end

  def create_cargo_train(train_number)
    @trains[train_number] = CargoTrain.new(train_number)
    puts "Поезд #{train_number} Создан"
  end

  def create_passenger_train(train_number)
    @trains[train_number] = PassengerTrain.new(train_number)
    puts "Поезд #{train_number} Создан"
  end

  def trains_list
    @trains.each do |name, value|
      puts "Поезд номер = #{name} Тип #{value.train_type}"
    end
  end

  def trains_menu
    loop do
      puts '1 Выбрать поезд'
      puts '2 Создать поезд'
      case gets.chomp.to_i
      when 1
        if @trains.any?

          puts 'Выберите поезд'
          trains_list
          train = gets.chomp.to_s

          train_menu(@trains[train])
        else
          puts 'Поездов нет'

        end
      when 2
        create_train
      else
        break
      end
    end
  end
end

Main.new.go
