puts 'Введите длинну 3 сторон треугольника'

puts 'Первая сторона'

a = gets.chomp.to_i
puts 'Вторая  сторона'
b = gets.chomp.to_i
puts 'Третья сторона'
c = gets.chomp.to_i

if a == b && b == c
  equilateral = true
else
  equilateral = false

  isosceles = a == b || b == c || a == c ? true : false
end
side = [a, b, c]
hypotenuse = side.max

side.delete_at(side.index(hypotenuse))
right_triangle = (hypotenuse**2) == ( (side[0]**2) + (side[1]**2) ) ? true : false
if equilateral
  puts 'Треугольник равносторонний'
elsif isosceles && right_triangle
  puts 'Треугольник равнобедренный и прямоугольный'
elsif !isosceles && right_triangle
  puts 'Треугольник прямоугольный'
elsif isosceles && !right_triangle
  puts 'Равнобедренный треугольник'
else
  puts 'Просто треугольник'
end 

