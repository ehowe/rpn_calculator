# frozen_string_literal: true

require_relative 'cli'
require_relative 'errors'

module Rpn
  # :nodoc:
  class Main
    include Rpn::Errors

    class << self
      attr_accessor :operators
    end

    self.operators = %w(+ - * /)

    def self.process(user_input)
      expression = user_input.split

      # if there are no operators in the array, the user specified the wrong one, or not at all
      raise InvalidOperatorError if expression.length > 1 && (expression - operators).length == expression.length

      # everything that isn't a recognized operator should be a number
      raise InvalidOperandError unless (expression - operators).all? { |operand| operand.match(/[.\d]+/) }

      # if more or less than 3 arguments are present, raise an error
      raise NotEnoughArgumentsError if expression.length < 3
      raise TooManyArgumentsError if expression.length > 3

      if expression.count == 1
        expression.first.to_f
      else
        expression.first.to_f.send(expression.last, expression[1].to_f)
      end
    end
  end
end
