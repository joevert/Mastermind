require 'colorize'

COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']

def generate_secret_code
  secret_code = Array.new(4) {COLORS.sample}
  puts secret_code
end

def get_player_input
  puts "Choose 4 colors between: #{COLORS.join(', ')}"
  puts "Input the 4 colors separated by space (ex: red blue yellow yellow)"

  loop do
    input = gets.chomp.downcase.split
    if input.length == 4 && input.all? { |color| COLORS.include?(color)}
      return input
    else
      puts "Invalid input. Please choose 4 valid colours."
      puts "Try again (ex: yellow blue purple orange):"
    end
  end
end