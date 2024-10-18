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

def compare_codes(secret_code, player_guess)
  exact_matches = []
  partial_matches = []
  feedback = []

  secret_code_copy = secret_code.dup
  player_guess_copy = player_guess.dup

  secret_code.each_with_index do |color, index|
    if color == player_guess[index]
      exact_matches << index
      feedback[index] << "\e[42m  \e[0m"
      secret_code_copy[index] = nil
      player_guess_copy[index] = nil
    else
      feedback[index] = nil
    end
  end

  player_guess_copy.each_with_index do |color, index|
    next if color.nil?
    
    if secret_code_copy.include?(color)
      feedback[index] = "\e[43m  \e[0m"
      secret_code_copy[secret_code_copy.index(color)] = nil
    end
  end

  feedback.map!{|f| f || "\e[47m \e[0m"}

  return feedback, exact_matches, partial_matches
  
end