Array.class_eval do
  def sum
    reduce(0, :+)
  end

  def square
    map { |num| num ** 2}
  end

  def square!
    map! { |num| num ** 2}    
  end
end
