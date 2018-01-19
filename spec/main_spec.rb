# frozen_string_literal: true

require 'spec_helper'

describe Rpn::Main do
  describe '.process' do
    let(:number1) { SecureRandom.random_number(100) }
    let(:number2) { SecureRandom.random_number(100) }

    {'addition' => '+', 'subtraction' => '-', 'multiplication' => '*', 'division' => '/'}.each do |operation, operator|
      it "processes a valid #{operation}" do
        expect(Rpn::Main.process("#{number1} #{number2} #{operator}")).to eq(number1.to_f.send(operator, number2.to_f))
      end
    end

    it 'raises an error when you use the wrong operator' do
      expect { Rpn::Main.process("#{number1} #{number2} x") }.to raise_error(Rpn::Errors::InvalidOperatorError)
    end

    it 'raises an error when you use a bad operand' do
      expect { Rpn::Main.process("#{number1} NaN *") }.to raise_error(Rpn::Errors::InvalidOperandError)
    end

    it 'raises an error when you use too many arguments' do
      expect { Rpn::Main.process("#{number1} #{number2} 3 *") }.to raise_error(Rpn::Errors::TooManyArgumentsError)
    end

    it 'raises an error when you use too few arguments' do
      expect { Rpn::Main.process("#{number1} *") }.to raise_error(Rpn::Errors::NotEnoughArgumentsError)
    end
  end
end
