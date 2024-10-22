class Computer
  def initialize(colors)
    @colors = colors
    @previous_guess = nil
  end

  def guess(feedback = nil)
    if @previous_guess.nil?
      @previous_guess = Code.generate(@colors)
    else
      update_guess_based_on_feedback(feedback)
    end
    puts "This is the current guess: #{@previous_guess}"
    @previous_guess
  end

  private

  def update_guess_based_on_feedback(feedback)
    
    if feedback && feedback[:exact]
      feedback[:exact].each do |index|
        @previous_guess[index] = @previous_guess[index]
      end
    end
    
    if feedback && feedback[:partial] && !feedback[:partial].empty?
      partial_colors = feedback[:partial].map { |index| @previous_guess[index] }

      (0...@previous_guess.size).each do |index|
        if !feedback[:exact].include?(index)
          @previous_guess[index] = nil
        end
      end
      
      partial_colors.each do |color|
        empty_index = find_different_empty_index(@previous_guess, feedback[:partial])
        @previous_guess[empty_index] = color if empty_index
      end
    end

    (0...@previous_guess.size).each do |index|      
      if !feedback[:exact].include?(index) && !feedback[:partial].include?(index)
        @previous_guess[index] = nil
      end
    end
    
    @previous_guess.map! do |color| 
      color || @colors.sample
    end
    
  end

  def find_different_empty_index(guess, partial_indexes)
    empty_index = guess.find_index(nil)

    while empty_index && partial_indexes.include?(empty_index)
      empty_index = nil
      guess.each_with_index do |value, index|
        if value.nil? && !partial_indexes.include?(index)
          empty_index = index
          break
        end
      end
    end
    empty_index
  end
  
end