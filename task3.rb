require 'securerandom'
require 'openssl'
require 'terminal-table'

key = SecureRandom.hex(32).upcase

comp_choice = ARGV.sample

hmac = OpenSSL::HMAC.hexdigest('sha256', key, comp_choice)

puts "HMAC:#{hmac}"

ARGV.each_with_index { |choice, i| puts "#{i + 1} #{choice}" }

print "Enter your move:"

user_choice = STDIN.gets.chomp.to_i

puts "Your move: #{ARGV[user_choice - 1]}"

puts "Computer move: #{comp_choice}"

p ARGV.index(comp_choice)

step_count = ARGV.count
# p step_count
formula = ((user_choice - 1) - ARGV.index(comp_choice) + step_count + step_count / 2) % step_count - step_count / 2

if formula == 1
  puts "You win"
elsif formula == -1 
  puts "You lose"
else 
  puts "Draw"
end 

puts "HMAC key:#{key}"

# check_choice = STDIN.gets.chomp
# mac2 = OpenSSL::HMAC.hexdigest('sha256', key, check_choice)
# p hmac == mac2
table = Terminal::Table.new do |t|
  t << ["v PC\\User >", "#{ARGV[0]}", "#{ARGV[1]}", "#{ARGV[2]}"]
  t << :separator
  t.add_row ["#{ARGV[0]}", "Draw", "Win", "Lose"]
  t.add_separator
  t.add_row ["#{ARGV[1]}", "Lose", "Draw", "Win"]
  t.add_separator
  t.add_row ["#{ARGV[2]}", "Win", "Lose", "Draw"]
end

puts table