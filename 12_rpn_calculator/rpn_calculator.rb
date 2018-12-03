# Context
class RPNCalculator
  attr_reader :array
  attr_accessor :strategy

  def initialize
    @array = []
  end

  def push(number)
    array << number
  end

  def value
    array.last
  end

  def plus
    set_operation(:+)
    execute_operation
  end

  def minus
    set_operation(:-)
    execute_operation
  end

  def times
    set_operation(:*)
    execute_operation
  end

  def divide
    set_operation(:/)
    execute_operation
  end

  def tokens(string)
    string.split.map do |item| 
      if item.match(/^[0-9]*$/)
        item.to_i 
      else 
        item.to_sym
      end
    end
  end

  def evaluate(string)
    tokens(string).map do |value|
      if value.is_a?(Integer)
        array.push(value)
      else
        set_operation(value)
        execute_operation
      end
    end
    result = array.join.to_f
    @array.clear
    result
  end

  # TODO find out why plain `strategy` does not work
  def set_operation(operation)
    @strategy = case operation
    when :+ then Addition.new   
    when :- then Subtraction.new
    when :* then Multiplication.new
    when :/ then Division.new
    end
  end

  def execute_operation
    raise "calculator is empty" if array.length < 2
    val1 = array.pop
    val2 = array.pop
    array << @strategy.do_operation(val2, val1)
  end
end

# Common interface for all strategies
# EDIT: Is this needed?
class Operation
  def do_operation
    raise NotImplementedError, 'Ask the subclass'
  end
end

# Concrete strategies
class Addition < Operation
  def do_operation(val1, val2)
    val1 + val2
  end
end

class Subtraction < Operation
  def do_operation(val1, val2)
    val1 - val2
  end
end

class Multiplication < Operation
  def do_operation(val1, val2)
    val1 * val2
  end
end

class Division < Operation
  def do_operation(val1, val2)
    val1 / val2.to_f
  end
end
