# frozen_string_literal: true

class Wagon
  include CompName

  attr_reader :wagon_type, :number

  def initialize(number)
    @number = number
  end
end
