module InWords
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
      if n < 20
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
      if n / 10**3 >= 100
        get_hundreds.call(n / 10**3) + " thousand" + (n % 10**3 == 0 ? "" : " " + get_hundreds.call(n % 10**3))
      elsif n / 10**3 > 0
        get_tens.call(n / 10**3).lstrip + " thousand" + (n % 10**3 == 0 ? "" : " " + get_hundreds.call(n % 10**3))
      else
        get_hundreds.call(n % 10**3)
      end
    }

    get_millions  = ->(n) {
      if n / 10**6 >= 100
        get_hundreds.call(n / 10**6) + " million" + (n % 10**6  == 0 ? "" : " " + get_thousands.call(n % 10**6))
      elsif n / 10**6 > 0
        get_tens.call(n / 10**6).lstrip + " million" + (n % 10**6 == 0 ? "" : " " + get_thousands.call(n % 10**6))
      else  
        get_thousands.call(n % 10**6)
      end
    }

    get_billions  = ->(n) {
      if n / 10**9 >= 100
        get_hundreds.call(n / 10**9) + " billion" + (n % 10**9  == 0 ? "" : " " + get_millions.call(n % 10**9))
      elsif n / 10**9 > 0
        get_tens.call(n / 10**9).lstrip + " billion"  + (n % 10**9 == 0 ? "" : " " + get_millions.call(n % 10**9))
      else
        get_millions.call(n % 10**9)
      end  
    }

    get_trillions = ->(n) {
      if n / 10**12 >= 100
        get_hundreds.call(n / 10**12) + " trillion" + (n % 10**12  == 0 ? "" : " " + get_billions.call(n % 10**12))
      elsif n / 10**12 > 0
        get_tens.call(n / 10**12).lstrip + " trillion"  + (n % 10**12 == 0 ? "" : " " + get_billions.call(n % 10**12))
      else
        get_billions.call(n % 10**12)
      end
    }

    if    self < 20     then zero_to_nineteen[self]
    elsif self < 100    then get_tens.call(self)
    elsif self < 10**3  then get_hundreds.call(self)
    elsif self < 10**6  then get_thousands.call(self)
    elsif self < 10**9  then get_millions.call(self)
    elsif self < 10**12 then get_billions.call(self)
    elsif self < 10**15 then get_trillions.call(self)
    end
  end
end

Fixnum.class_eval do
  include InWords
end
