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

  def tokens(string)
    string.split.map do |item| 
      if item.match(/^[0-9]*$/)
        item.to_i 
      else 
        item.to_sym
      end
    end
  end
end
