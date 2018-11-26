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

    get_under_hundred = ->(n) { case n
      when 11..19 then zero_to_nineteen[n]
      else tens[n / 10] + (n % 10 == 0 ? "" : " " + zero_to_nineteen[n % 10]) 
      end
    }
    get_under_thousand = ->(n) { zero_to_nineteen[n / 100] + " hundred" + (n % 100  == 0 ? "" : " " + get_under_hundred.call(n % 100)) }
    get_under_million = ->(n) { get_under_hundred[n / 1000].lstrip + " thousand" + (n % 1000  == 0 ? "" : " " + get_under_thousand.call(n % 1000)) }

    if    self < 20        then zero_to_nineteen[self]
    elsif self < 100       then get_under_hundred.call(self)
    elsif self < 1_000     then get_under_thousand.call(self)
    elsif self < 1_000_000 then get_under_million.call(self)
    end
  end
end
