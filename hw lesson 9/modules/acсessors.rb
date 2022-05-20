# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend self
  end

  def attr_accessor_with_history(*methods)
    methods.each do |method|
      var_name = "@#{method}".to_sym
      var_name_history = "@#{method}_history".to_sym

      define_method(method) { instance_variable_get(var_name) }
      define_method("#{method}_history") { instance_variable_get(var_name_history) }

      define_method("#{method}=".to_sym) do |value|
        instance_variable_set "@#{method}_history".to_sym, [] if instance_variable_get("@#{method}_history".to_sym).nil?
        instance_variable_get ("@#{method}_history".to_sym) << value
        instance_variable_set("@#{method}".to_sym, value)
      end
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неверный тип' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
