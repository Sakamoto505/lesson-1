# frozen_string_literal: true

require_relative 'wagon'
class WagonCargo < Wagon
  attr_reader :wagon_type, :volume, :number, :free_volume
  attr_accessor :taken_volume

  def initialize(number, volume)
    super(number)
    @wagon_type = :cargo
    @volume = volume
    @taken_volume = 0
    @free_volume = volume
  end

  def take_volume(volume)
    raise 'Нет места.' if @free_volume.zero? || (@free_volume - volume) <= 0

    @free_volume -= volume
    puts "Теперь объёем равен: #{free_volume}"
  end

  def busy_volume
    @volume - @free_volume
  end
end
