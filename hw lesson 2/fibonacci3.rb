fib = [0]
f_num = 1
while f_num < 100
  fib << f_num 
  f_num = fib[-1] + fib[-2]
end
  puts fib
