# RPN Calculator

Provides a gem for doing RPN calculations.  The gem includes an executable, as well as a library for integrating with other services.

## Main

The `Main` class provides the library for use with the CLI or other services.

### Usage

The class level method `.process` provides all of the functionality here.  It takes an RPN formatted equation as an argument and returns a floating point answer.

For the purposes of this calculator, the string should be space delimited and consist of 2 numbers and an operator: `2 5 +`

Valid operators are: `+ - * /`

```
Rpn::Main.process("2 5 +")
=> 7.0
```

So what if we specify invalid input?

#### Invalid Operators

```
Rpn::Main.process("2 5 x")
=> Rpn::Errors::InvalidOperatorError (Rpn::Errors::InvalidOperatorError)
```

#### Invalid Operands

```
Rpn::Main.process("2 q *")
Rpn::Errors::InvalidOperandError (Rpn::Errors::InvalidOperandError)
```

#### Too Many Arguments

```
Rpn::Main.process("2 5 5 *")
Rpn::Errors::TooManyArgumentsError (Rpn::Errors::TooManyArgumentsError)
```

#### Not Enough Arguments

```
Rpn::Main.process("2 *")
Rpn::Errors::NotEnoughArgumentsError (Rpn::Errors::NotEnoughArgumentsError)
```

## CLI

There is a helper executable for the CLI in the `bin` directory called `rpn`.  This starts the REPL for the calculator CLI.

### Usage

You are greeted with a usage message upon starting the REPL which includes usage instructions

```
Reverse polish notation calculator.
Each line should contain an expression that has 2 numbers an operator.
Eg: 2 5 +
Enter 'c' or 'clear' to clear the stored last value
Enter 'q' or 'quit' to exit
>
```

Each line should be formatted as an RPN equation (the same way as the Main.process method)

```
> 2 5 +
7.0
>
```

With the CLI version, the last return value is stored for additional calculations.  The last stored value is passed as the first argument for the next equation.

```
> 2 5 +
7.0
> 3 -
4.0
> 5 *
20.0
```

All of the error classes mentioned above are handled as well and restart the loop

```
> 2 +
Not enough arguments are present. Input should be 2 numbers as an operator.  The output of the previous calculation will be used as the first argument if present
```
