require 'addition'
require 'subtraction'
require 'multiplication'
require 'division'

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
