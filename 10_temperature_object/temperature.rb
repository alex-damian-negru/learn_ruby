class Temperature
  def initialize(options)
    @celsius    = options[:c]
    @fahrenheit = options[:f]
  end

  def in_fahrenheit
    return @fahrenheit unless @fahrenheit.nil?
    @celsius.to_f * 9/5 + 32
  end

  def in_celsius
    @celsius.nil? ? (@fahrenheit.to_f - 32) * 5/9 : @celsius
  end

  def self.from_celsius(temp)
    new(:c => temp)
  end

  def self.from_fahrenheit(temp)
    new(:f => temp)
  end
end

class Celsius < Temperature
  def initialize(celsius)
    @celsius = celsius
  end
end

class Fahrenheit < Temperature
  def initialize(fahrenheit)
    @fahrenheit = fahrenheit
  end
end
