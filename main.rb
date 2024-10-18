require 'colorize'

COLORS = ['red', 'blue', 'green', 'yellow', 'orange', 'purple']

def generate_secret_code
  secret_code = Array.new(4) {COLORS.sample}
  puts secret_code
end