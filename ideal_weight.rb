puts "Как тебя зовут?"
name = gets.chomp
puts "Какой у тебя рост?"
height = gets.chomp.to_i

body_mass = (height  - 100) *1.15
if body_mass > 0
    puts "#{name} идеальный вес для вас #{body_mass}кг "
else 
    puts "У вас оптимальный вес"
end