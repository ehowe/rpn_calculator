# frozen_string_literal: true

module Rpn
  module Errors
    # :nodoc:
    class InvalidOperandError < StandardError
      def message
        'Operands must be integers or floating point numbers'
      end
    end

    # :nodoc:
    class InvalidOperatorError < StandardError
      def message
        "No (or invalid) operator specified.  Valid operators are: #{Rpn::Main.operators.join(',')}"
      end
    end

    # :nodoc:
    class TooManyArgumentsError < ArgumentError
      def message
        'Too many arguments are present. Input should be 2 numbers and an operator'
      end
    end

    # :nodoc:
    class NotEnoughArgumentsError < ArgumentError
      def message
        'Not enough arguments are present. Input should be 2 numbers as an operator.  The output of the previous calculation will be used as the first argument if present'
      end
    end
  end
end
