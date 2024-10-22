require_relative 'player'
require_relative 'computer'
require_relative 'code'
require_relative 'feedback'

class Game
  COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']

  def initialize
    @max_turns = 12
  end

  def start
    puts "Welcome to Mastermind!"
    mode = choose_mode
    mode == 1 ? play_as_guesser : play_as_masterminder
  end

  def choose_mode
    puts "Press 1 to guess the code, or 2 to let the computer guess your code."
    loop do
      value = gets.chomp.to_i
      return value if [1, 2].include?(value)
      puts "Invalid option, please try again."
    end
  end

  def play_as_guesser
    secret_code = Code.generate(COLORS)
    player = Player.new
    play_game(secret_code, player)
  end

  def play_as_masterminder
    secret_code = Player.new.choose_code(COLORS)
    computer = Computer.new(COLORS)
    play_game(secret_code, computer)
  end

  def play_game(secret_code, participant)
    feedback = nil
    @max_turns.times do |turn|
      puts "\nTurn #{turn + 1}"
      guess = participant.guess(feedbackgame)
      feedback = Code.compare(secret_code, guess)
      Feedback.new(feedback).display

      if feedback[:exact].length == secret_code.length
        puts participant.is_a?(Computer) ? "The computer guessed your code!" : "Congratulations! You guessed the code!"
        return
      end
    end

    puts "Sorry, the correct code was: #{secret_code.join(', ')}"
  end
end