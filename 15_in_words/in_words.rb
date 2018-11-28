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
      if n / digits >= 100
        curr_group = get_hundreds(n / digits) + " #{group}"
        words += curr_group + (n % digits > 0 ? " " : "")
        n %= digits
        digits /= 10**3

      elsif n / digits > 0
        curr_group = get_tens(n / digits) + " #{group}"
        words += curr_group + (n % digits > 0 ? " " : "")
        n %= digits
        digits /= 10**3
        
      else
        digits /= 10**3
      end
    end
    words.end_with?(" ") ? words[0..-2] : words
  end

  def in_words
    case self
    when 0...20     then zero_to_nineteen(self)
    when 20...100   then get_tens(self)
    when 100...1000 then get_hundreds(self)
    else get_upto_trillions(self)
    end
  end
end

Fixnum.class_eval do
  include InWords
end
