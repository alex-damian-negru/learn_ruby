module InWords
  def zero_to_nineteen(n)
    ["zero", "one", "two", "three", "four", 
    "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", 
    "fourteen", "fifteen", "sixteen", 
    "seventeen", "eighteen", "nineteen"
    ][n]
  end

  def tens(n)
    ["", "ten", "twenty", "thirty", "forty", 
    "fifty", "sixty", "seventy", "eighty", "ninety"
    ][n]
  end

  def get_tens(n)
    return zero_to_nineteen(n) if n < 20
    tens(n / 10) + (n % 10 == 0 ? "" : " " + zero_to_nineteen(n % 10)) 
  end

  def get_hundreds(n)
    return get_tens(n % 100) if n / 100 == 0 
    zero_to_nineteen(n / 100) + " hundred" + (n % 100  == 0 ? "" : " " + get_tens(n % 100))
  end

  def get_upto_trillions(n)
    words = ""
    digits = 10**12
    ["trillion", "billion", "million", "thousand", ""].map do |group|
      if hundreds?(n, digits)
        words += get_hundreds(n / digits) + " #{group}" + space(n, digits)
        n %= digits
        digits /= 1000
      elsif tens?(n, digits)
        words += get_tens(n / digits) + " #{group}" + space(n, digits)
        n %= digits
        digits /= 1000
      else
        digits /= 1000
      end
    end
    words.end_with?(" ") ? words[0..-2] : words
  end

  def hundreds?(n, digits)
    n / digits >= 100
  end

  def tens?(n, digits)
    n / digits > 0
  end
  
  def space(n, digits)
    n % digits > 0 ? " " : ""
  end

  def in_words
    return zero_to_nineteen(self) if self < 20
    get_upto_trillions(self)
  end
end

Fixnum.class_eval do
  include InWords
end
