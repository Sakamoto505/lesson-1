# frozen_string_literal: true

module CompName
  def add_name(name)
    self.comp_name = name
  end

  def show_comp
    comp_name
  end

  protected

  attr_accessor :comp_name
end
