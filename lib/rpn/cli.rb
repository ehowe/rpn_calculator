# frozen_string_literal: true

require_relative 'main'
require_relative 'errors'

module Rpn
  #:nodoc:
  class CLI
    include Rpn::Errors

    at_exit { puts 'Goodbye...' }

    HEADER = <<~EOF
      Reverse polish notation calculator.
      Each line should contain an expression that has 2 numbers an operator.
      Eg: 2 5 +
      Enter 'c' or 'clear' to clear the stored last value
      Enter 'q' or 'quit' to exit
    EOF
    attr_accessor :last_value

    def run
      puts HEADER
      loop do
        print "> "
        user_input = $stdin.gets

        # ctrl-d or empty input is invalid
        raise InvalidOperandError if user_input.nil? || user_input.chomp.empty?
        raise Interrupt if user_input.match(/^c(?:lear)?/)

        break if user_input.match(/^q(?:uit)?/)

        user_input.chomp!

        # if the user only specified 2 arguments, we can assume they want to operate on the last returned value
        user_input = "#{last_value} #{user_input}" if last_value && user_input.split.length == 2

        last_value = Rpn::Main.process(user_input)
        puts last_value
      rescue InvalidOperandError, InvalidOperatorError, TooManyArgumentsError, NotEnoughArgumentsError => e
        $stderr.puts e.message
      rescue Interrupt
        @last_value = nil
        puts "Clearing..."
        retry
      end
    end
  end
end
