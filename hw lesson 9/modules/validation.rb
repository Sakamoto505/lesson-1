# frozen_string_literal: true

require 'pry'
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, *options)
      @validations ||= []
      @validations << { name: name, type: type, options: options }
    end
  end

  module InstanceMethods
    def validate!
      # будут браться валидации из класса текущего объекта
      # и из родительского класса(superclass) если в нем тоже будут описаны валидации,
      # к примеру если часть общих валидаци если в классе Train а часть описаны в CargoTrain и/или PassengerTrain
      # таким образом я попытался сделать так что бы валидации наследовались в классах потомках
      validations = self.class.validations || []
      validations += self.class.superclass.validations || [] if self.class.superclass.respond_to?('validations')

      validations.each do |value|
        field_value = instance_variable_get("@#{value[:name]}")
        send("validate_#{value[:type]}", field_value, value[:options])
      end
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate_presence(name, *)
    raise 'Значение атрибута  nil' if name.nil? || name.empty?
  end

  def validate_format(name, format)
    raise 'Неверный формат' if name !~ format.first
  end

  def validate_min_length(name, length)
    raise "Должно быть больше #{length.first} символов" if name.length < length.first
  end

  def validate_type(name, type)
    raise 'Не соответствие значения атрибута' unless name.is_a?(type.first)
  end
end
