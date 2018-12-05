class RPNCalculator
  attr_reader :array

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
    do_operation(:+)
  end

  def minus
    do_operation(:-)
  end

  def times
    do_operation(:*)
  end

  def divide
    do_operation(:/)
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
      value.is_a?(Integer) ? array.push(value) : do_operation(value)
    end
    result = array.join.to_f
    array.clear
    result
  end

  def do_operation(operation)
    raise "calculator is empty" if array.length < 2
    strategy = OperationFactory.create(operation)
    val1 = array.pop
    val2 = array.pop
    array << strategy.compute(val2, val1)
  end
end

class OperationFactory
  def self.create(operation)
    case operation
    when :+ then Addition.new
    when :- then Subtraction.new
    when :* then Multiplication.new
    when :/ then Division.new   
    end
  end
end

class Operation
  def do_operation(val1, val2)
    raise NotImplementedError, 'Method must be implemented in the child class'
  end
end

class Addition < Operation
  def compute(val1, val2)
    val1 + val2
  end
end

class Subtraction < Operation
  def compute(val1, val2)
    val1 - val2
  end
end

class Multiplication < Operation
  def compute(val1, val2)
    val1 * val2
  end
end

class Division < Operation
  def compute(val1, val2)
    val1 / val2.to_f
  end
end
