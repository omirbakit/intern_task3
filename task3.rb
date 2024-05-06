require 'securerandom'
require 'openssl'
require 'terminal-table'

key = SecureRandom.hex(32).upcase

duplicates = []

ARGV.each do |element|
  duplicates << element if ARGV.count(element) > 1
end

duplicates = duplicates.uniq

if ARGV.count.between?(0, 2)
  puts "Number of arguments should be more than 2\nYou entered #{ARGV.count} arguments"

elsif ARGV.count.even?
  puts "Number of arguments should be odd number \nYou entered #{ARGV.count} arguments"

elsif duplicates.size > 0

  puts  "Do not duplicate arguments.\nYou entered '#{duplicates.uniq.join}' more than one times."

else duplicates.size == 0 && ARGV.count >= 3 && ARGV.count.odd?

  loop do

    comp_choice = ARGV.sample

    hmac = OpenSSL::HMAC.hexdigest('sha256', key, comp_choice)
    puts
    puts "HMAC:#{hmac}"

    ARGV.each_with_index { |choice, i| puts "#{i + 1} - #{choice}" }

    puts "0 - exit"

    puts "? - help"

    print "Enter your move:"

    user_choice = STDIN.gets.chomp

    if user_choice.to_i > 0 && user_choice.to_i <= ARGV.count 

      puts "Your move: #{ARGV[user_choice.to_i - 1]}"

      puts "Computer move: #{comp_choice}"

      step_count = ARGV.count
      
      formula = ((user_choice.to_i - 1) - ARGV.index(comp_choice) + step_count + step_count / 2) % step_count - step_count / 2

      if formula == 1
        puts "You win"
      elsif formula == -1 
        puts "Computer win"
      else 
        puts "Draw"
      end
    elsif user_choice == '?'
      if ARGV.count == 3
        table = Terminal::Table.new do |t|
          t << ["v PC\\User >", "#{ARGV[0]}", "#{ARGV[1]}", "#{ARGV[2]}"]
          t << :separator
          t.add_row ["#{ARGV[0]}", "Draw", "Win", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[1]}", "Lose", "Draw", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[2]}", "Win", "Lose", "Draw"]
        end
      elsif ARGV.count == 5
        table = Terminal::Table.new do |t|
          t << ["v PC\\User >", "#{ARGV[0]}", "#{ARGV[1]}", "#{ARGV[2]}", "#{ARGV[3]}", "#{ARGV[4]}"]
          t << :separator
          t.add_row ["#{ARGV[0]}", "Draw", "Win", "Win", "Lose", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[1]}", "Lose", "Draw", "Win", "Win", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[2]}", "Lose", "Lose", "Draw", "Win", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[3]}", "Win", "Lose", "Lose", "Draw", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[4]}", "Win", "Win", "Lose", "Lose", "Draw"]
        end
      elsif ARGV.count == 7
        table = Terminal::Table.new do |t|
          t << ["v PC\\User >", "#{ARGV[0]}", "#{ARGV[1]}", "#{ARGV[2]}", "#{ARGV[3]}", "#{ARGV[4]}", "#{ARGV[5]}", "#{ARGV[6]}"]
          t << :separator
          t.add_row ["#{ARGV[0]}", "Draw", "Win", "Win", "Win", "Lose", "Lose", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[1]}", "Lose", "Draw", "Win", "Win", "Win", "Lose", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[2]}", "Lose", "Lose", "Draw", "Win", "Win", "Win", "Lose"]
          t.add_separator
          t.add_row ["#{ARGV[3]}", "Lose", "Lose", "Lose", "Draw", "Win", "Win", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[4]}", "Win", "Lose", "Lose", "Lose", "Draw", "Win", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[5]}", "Win", "Win", "Lose", "Lose", "Lose", "Draw", "Win"]
          t.add_separator
          t.add_row ["#{ARGV[6]}", "Win", "Win", "Win", "Lose", "Lose", "Lose", "Draw"]
        end
      end
      puts table
    else user_choice.to_i == 0
      puts "Bye"
      break
    end
    puts "HMAC key:#{key}"
  end
end
