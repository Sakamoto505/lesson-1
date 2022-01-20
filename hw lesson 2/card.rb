# frozen_string_literal: true

card = {}
total = 0

loop do
  puts '1. название товара'
  name = gets.chomp
  break if name.downcase == 'стоп'

  puts '2. цену за единицу'
  price = gets.chomp.to_f

  puts '3. кол-во купленного товара'
  count = gets.chomp.to_f

  card[name] = {
    price: price,
    count: count,
    total: price * count
  }

  total += price * count

  puts "Товар #{name}, цена покупки #{card[name][:total]}"
end

puts total
