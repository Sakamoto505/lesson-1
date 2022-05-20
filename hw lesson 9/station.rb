# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  extend Accessors
  attr_accessor :trains, :name

  NAME_FORMAT = /[a-z]/i.freeze
  validate :name, :format, NAME_FORMAT
  validate :name, :min_length, 7

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations.push(self)
    register_instance
  end

  def add_train(train)
    @trains << train if train.route.stations.include?(self)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_list_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def trains_list(&block)
    trains.each do |train|
      block.call(train)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # def validate!
  #   raise 'Название станции должно быть больше 6 символов' if @name.length < 6
  #   raise 'Названия станций должны состоять только из букв' if @name !~ NAME_FORMAT
  # end
end
