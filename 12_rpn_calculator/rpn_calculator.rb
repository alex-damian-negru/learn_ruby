class RPNCalculator
  def array
    @array ||= []
  end

  def push(number)
    array << number
  end

  def plus
    result = array.last
    array.pop
    array[-1] += result
  end

  def minus
    result = array.last
    array.pop
    array[-1] -= result
  end

  def value
    array.last
  end
end
