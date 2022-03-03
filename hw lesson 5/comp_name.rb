# frozen_string_literal: true

Module CompName
def comp_name(name)
  self.comp_name = name
end

def show_comp
  comp_name
end

private

attr_accessor :comp_name
