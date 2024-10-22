class Feedback
  def initialize(feedback)
    @feedback = feedback
  end

  def display
    feedback_str = Array.new(4) { "\e[47m  \e[0m" }
    
    @feedback[:exact].each { |index| feedback_str[index] = "\e[42m  \e[0m" }
    @feedback[:partial].each { |index| feedback_str[index] = "\e[43m  \e[0m" }

    puts "Feedback: #{feedback_str.join(' ')}"
  end
end