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
    puts "este é o palpite atual: #{@previous_guess}"
    @previous_guess
  end

  private

  def update_guess_based_on_feedback(feedback)
    
    puts "Feedback recebido: #{feedback.inspect}" # Inspeciona o feedback

      # Atualizar posições de acertos exatos
    if feedback && feedback[:exact]
      feedback[:exact].each do |index|
        @previous_guess[index] = @previous_guess[index]
      end
    end

      # Verificar se feedback parcial está presente e contém dados
    if feedback && feedback[:partial] && !feedback[:partial].empty?
      puts "Executando lógica de feedback parcial"

      partial_colors = feedback[:partial].map { |index| @previous_guess[index] }

      puts "esses sao os palpites parciais #{partial_colors}"

      # Limpar as cores parciais das posições anteriores
      (0...@previous_guess.size).each do |index|
        # Verificar se o índice NÃO está presente nos feedbacks de 'exact' ou 'partial'
        if !feedback[:exact].include?(index)
          @previous_guess[index] = nil
        end
      end

      # Redistribuir as cores parciais em novas posições
      partial_colors.each do |color|
        empty_index = find_different_empty_index(@previous_guess, feedback[:partial])
        @previous_guess[empty_index] = color if empty_index
      end
    else
      puts "Feedback parcial não presente ou vazio"
    end

    (0...@previous_guess.size).each do |index|
      # Verificar se o índice NÃO está presente nos feedbacks de 'exact' ou 'partial'
      if !feedback[:exact].include?(index) && !feedback[:partial].include?(index)
        @previous_guess[index] = nil
      end
    end

    # Preencher posições restantes com cores aleatórias
    @previous_guess.map! do |color| 
      color || @colors.sample
    end
    
  end

  def find_different_empty_index(guess, partial_indexes)
    empty_index = guess.find_index(nil)

    while empty_index && partial_indexes.include?(empty_index)
      # Usar each_with_index para encontrar o próximo índice vazio
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