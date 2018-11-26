Fixnum.class_eval do
  def in_words
    zero_to_nineteen = [
      "zero", "one", "two", "three", "four", 
      "five", "six", "seven", "eight", "nine",
      "ten", "eleven", "twelve", "thirteen", 
      "fourteen", "fifteen", "sixteen", 
      "seventeen", "eighteen", "nineteen"
    ]

    tens = [ 
      "", "ten", "twenty", "thirty", "forty", 
      "fifty", "sixty", "seventy", "eighty", "ninety"
    ]

    get_under_100 = ->(n) { case n
      when 11..19 
        zero_to_nineteen[n]
      else 
        tens[n / 10] + (n % 10 == 0 ? "" : " " + zero_to_nineteen[n % 10]) 
      end
    }
    get_under_1000 = ->(n) { zero_to_nineteen[n / 100] + " hundred" + (n % 100  == 0 ? "" : " " + get_under_100.call(n % 100)) }

    if self < 20
      zero_to_nineteen[self]

    elsif self < 100
      get_under_100.call(self)

    elsif self < 1000
      get_under_1000.call(self)
    end
  end
end
