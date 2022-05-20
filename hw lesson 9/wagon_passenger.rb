# frozen_string_literal: true

class WagonPassenger < Wagon
  attr_reader :wagon_type, :seats, :number, :free_seats
  attr_accessor :taken_place

  def initialize(number, seats)
    super(number)
    @wagon_type = :passenger
    @seats = seats
    @taken_place = 0
    @free_seats = seats
  end

  def take_place(seats)
    raise 'Нет места.' if @free_seats.zero? || (@free_seats - seats) <= 0

    @free_seats -= seats
    puts "Теперь объёем равен: #{@free_seats}"
  end

  def busy_seats
    @seats - @free_seats
  end
end
