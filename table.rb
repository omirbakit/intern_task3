require 'terminal-table'
require_relative 'runner'

class Table < Runner
    def initialize(*args)
        table = Terminal::Table.new do |t|
            t << ["v PC\\User >", "#{ARGV[0]}", "#{ARGV[1]}", "#{ARGV[2]}"]
            t << :separator
            t.add_row ["#{ARGV[0]}", "Draw", "Win", "Lose"]
            t.add_separator
            t.add_row ["#{ARGV[1]}", "Lose", "Draw", "Win"]
            t.add_separator
            t.add_row ["#{ARGV[2]}", "Win", "Lose", "Draw"]
          end
    end
    puts table
end
