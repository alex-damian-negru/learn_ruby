require 'operation_factory'

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
