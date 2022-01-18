puts "Введите 3 значения "
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f
 
dis = b * b - 4 * a * c 

if dis < 0 
  puts "Нет корней"
elsif dis == 0 
  x = -b / 2 * a

  puts "Есть только один корень #{x}"
else 
  x1 = (-b + Math.sqrt(dis)) / (2 * a)
  x2 = (-b - Math.sqrt(dis)) / (2 * a)
  puts "корень 1 #{x1}", "корень 2 #{x2},", "D равен #{dis}"
end