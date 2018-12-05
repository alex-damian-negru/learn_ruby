require 'Operation'

class Division < Operation
  def compute(val1, val2)
    val1 / val2.to_f
  end
end
