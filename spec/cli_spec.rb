# frozen_string_literal: true

require 'spec_helper'

describe Rpn::CLI do
  let(:number1) { SecureRandom.random_number(100) }
  let(:number2) { SecureRandom.random_number(100) }

  describe '#run' do
    it 'adds' do
      $stdin = StringIO.new("#{number1} #{number2} +\nquit\n")
      expect { subject.run }.to output(/#{number1.to_f + number2.to_f}/).to_stdout
      expect(subject.last_value).to eq((number1 + number2).to_f)
    end

    it 'subracts' do
      $stdin = StringIO.new("#{number1} #{number2} -\nquit\n")
      expect { subject.run }.to output(/#{number1.to_f - number2.to_f}/).to_stdout
    end

    it 'multiplies' do
      $stdin = StringIO.new("#{number1} #{number2} *\nquit\n")
      expect { subject.run }.to output(/#{number1.to_f * number2.to_f}/).to_stdout
    end

    it 'divides' do
      $stdin = StringIO.new("#{number1} #{number2} /\nquit\n")
      expect { subject.run }.to output(/#{number1.to_f / number2.to_f}/).to_stdout
    end

    it 'does a complex operation' do
      $stdin = StringIO.new("#{number1} #{number2} +\n3 *\n4 -\n5 /\nquit\n")
      expect { subject.run }.to output(/#{(((number1.to_f + number2.to_f) * 3) - 4) / 5}/).to_stdout
    end

    it 'clears' do
      $stdin = StringIO.new("#{number1} #{number2} +\nclear\nquit\n")
      subject.run
      expect(subject.last_value).to be_nil
    end

    it 'displays an InvalidOperandError if you specify no input' do
      $stdin = StringIO.new("\n\nquit\n")
      expect { subject.run }.to output(/#{Rpn::Errors::InvalidOperandError.new.message}/).to_stderr
    end

    it 'displays an InvalidOperandError if you specify a bad operator' do
      $stdin = StringIO.new("#{number1} #{number2} x\nquit\n")
      expect { subject.run }.to output(Rpn::Errors::InvalidOperatorError.new.message + "\n").to_stderr
    end

    it 'displays an argument error if you specify too many arguments' do
      $stdin = StringIO.new("#{number1} #{number2} 3 +\nquit\n")
      expect { subject.run }.to output(Rpn::Errors::TooManyArgumentsError.new.message + "\n").to_stderr
    end

    it 'displays an argument error if you specify too few arguments' do
      $stdin = StringIO.new("#{number1} +\nquit\n")
      expect { subject.run }.to output(Rpn::Errors::NotEnoughArgumentsError.new.message + "\n").to_stderr
    end

    after(:each) { $stdin = STDIN }
  end
end
