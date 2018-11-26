Array.class_eval do
  def sum
    reduce(0, :+)
  end
end
