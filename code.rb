class Code
  def self.generate(colors)
    Array.new(4) { colors.sample }
  end

  def self.compare(secret_code, guess)
    exact_matches = []
    partial_matches = []

    secret_code_copy = secret_code.dup
    guess_copy = guess.dup

    # First, find exact matches
    guess_copy.each_with_index do |color, index|
      if color == secret_code_copy[index]
        exact_matches << index
        secret_code_copy[index] = nil
        guess_copy[index] = nil
      end
    end

    # Then, find partial matches
    guess_copy.each_with_index do |color, index|
      next if color.nil?
      if secret_code_copy.include?(color)
        partial_matches << index
        secret_code_copy[secret_code_copy.index(color)] = nil
      end
    end

    { exact: exact_matches, partial: partial_matches }
  end
end
