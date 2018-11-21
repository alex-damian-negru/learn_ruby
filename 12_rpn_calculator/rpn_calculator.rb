class RPNCalculator
  def array
    @array ||= []
  end

  def push(number)
    array << number
  end

  def plus
    raise "calculator is empty" if array.length < 2
    result = array.last
    array.pop
    array[-1] += result
  end

  def minus
    raise "calculator is empty" if array.length < 2
    result = array.last
    array.pop
    array[-1] -= result
  end

  def times
    raise "calculator is empty" if array.length < 2
    result = array.last
    array.pop
    array[-1] *= result.to_f
  end

  def divide
    raise "calculator is empty" if array.length < 2
    result = array.last
    array.pop
    array[-1] /= result.to_f
  end

  def value
    array.last
  end
end
