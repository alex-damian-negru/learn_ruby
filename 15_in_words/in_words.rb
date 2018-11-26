Fixnum.class_eval do
  def in_words
    zero_to_nine = [
      "zero", "one", "two", "three", "four", 
      "five", "six", "seven", "eight", "nine"
    ]

    ten_to_nineteen = [
      "ten", "eleven", "twelve", "thirteen", 
      "fourteen", "fifteen", "sixteen", 
      "seventeen", "eighteen", "nineteen"
    ]

    tens = [
      "twenty", "thirty", "forty", "fifty",
      "sixty", "seventy", "eighty", "ninety"
    ]

    if self < 10 
      zero_to_nine[self]
    elsif self >= 10 && self < 20
      ten_to_nineteen[self % 10]
    elsif self % 10 == 0
      tens[self / 10 - 2]
    else
      tens[self % 10 - 2] + " " + zero_to_nine[self % 10]
    end
  end
end
