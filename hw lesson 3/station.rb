# frozen_string_literal: true

class Station
  attr_reader :name
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def  add_train(train)
    @trains << train
  end

  def send_trains(train)
    @trains.delete(train)
  end

  def trains_list_by_type(type)
    @trains.each { |train| train.type == type }
  end
end
