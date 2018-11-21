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

  def times
    result = array.last
    array.pop
    array[-1] *= result.to_f
  end

  def divide
    result = array.last
    array.pop
    array[-1] /= result.to_f
  end

  def value
    array.last
  end
end
