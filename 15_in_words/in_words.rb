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

    get_tens = ->(n) { 
      case n
      when 11..19 
        zero_to_nineteen[n]
      else 
        tens[n / 10] + (n % 10 == 0 ? "" : " " + zero_to_nineteen[n % 10]) 
      end
    }

    get_hundreds  = ->(n) {
      if n / 100 > 0 
        zero_to_nineteen[n / 100] + " hundred" + (n % 100  == 0 ? "" : " " + get_tens.call(n % 100))
      else
        get_tens[n % 100]
      end
    }

    get_thousands = ->(n) {
      if n / 1000 >= 100
        get_hundreds.call(n / 1000) + " thousand" + (n % 1000 == 0 ? "" : " " + get_hundreds.call(n % 1000))
      elsif n / 1000 > 0
        get_tens.call(n / 1000).lstrip + " thousand" + (n % 1000 == 0 ? "" : " " + get_hundreds.call(n % 1000))
      else
        get_hundreds.call(n % 1000)
      end
    }

    get_millions  = ->(n) {
      if n / 1_000_000 >= 100
        get_hundreds.call(n / 1_000_000) + " million" + (n % 1_000_000  == 0 ? "" : " " + get_thousands.call(n % 1_000_000))
      elsif n / 1_000_000 > 0
        get_tens.call(n / 1_000_000).lstrip + " million" + (n % 1_000_000 == 0 ? "" : get_thousands.call(n % 1_000_000))
      else  
        get_thousands.call(n % 1_000_000)
      end
    }

    get_billions  = ->(n) {
      if n / 1_000_000_000 >= 100
        get_hundreds.call(n / 1_000_000_000) + " billion" + (n % 1_000_000_000  == 0 ? "" : " " + get_millions.call(n % 1_000_000_000))
      elsif n / 1_000_000_000 > 0
        get_tens.call(n / 1_000_000_000).lstrip + " billion"  + (n % 1_000_000_000 == 0 ? "" : " " + get_millions.call(n % 1_000_000_000))
      else
        get_millions.call(n % 1_000_000_000)
      end  
    }

    get_trillions = ->(n) {
      if n / 1_000_000_000_000 >= 100
        get_hundreds.call(n / 1_000_000_000_000) + " trillion" + (n % 1_000_000_000_000  == 0 ? "" : " " + get_billions.call(n % 1_000_000_000_000))
      elsif n / 1_000_000_000_000 > 0
        get_tens.call(n / 1_000_000_000_000).lstrip + " trillion"  + (n % 1_000_000_000_000 == 0 ? "" : get_billions.call(n % 1_000_000_000_000))
      else
        get_billions.call(n % 1_000_000_000_000)
      end
    }

    if    self < 20                    then zero_to_nineteen[self]
    elsif self < 100                   then get_tens.call(self)
    elsif self < 1_000                 then get_hundreds.call(self)
    elsif self < 1_000_000             then get_thousands.call(self)
    elsif self < 1_000_000_000         then get_millions.call(self)
    elsif self < 1_000_000_000_000     then get_billions.call(self)
    elsif self < 1_000_000_000_000_000 then get_trillions.call(self)
    end
  end
end
