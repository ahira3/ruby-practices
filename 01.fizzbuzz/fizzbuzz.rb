# 3の倍数でFizz,5の倍数でBuzz,15の倍数でFizzBuzzと表示、
# それ以外は数値を表示する関数
def fizzbuzz(n)
  if n % 3 == 0 && n % 5 == 0
    puts "FizzBuzz"
  elsif n % 3 == 0
    puts "Fizz"
  elsif n % 5 == 0
    puts "Buzz"
  else
    puts n
  end
end

(1..20).each do |n|
  fizzbuzz(n)
end
