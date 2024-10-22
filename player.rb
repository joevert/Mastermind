class Player
  def choose_code(colors)
    puts "Choose 4 colors between: #{colors.join(', ')}"
    get_input(colors)
  end

  def guess
    puts "Enter your guess: 4 colors separated by spaces (ex: red blue yellow green)"
    get_input(Game::COLORS)
  end

  private

  def get_input(colors)
    loop do
      input = gets.chomp.downcase.split
      return input if input.length == 4 && input.all? { |color| colors.include?(color) }
      puts "Invalid input. Please enter 4 valid colors."
    end
  end
end