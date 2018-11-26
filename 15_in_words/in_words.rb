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

    if self < 10 
      zero_to_nine[self]
    elsif self >= 10 
      ten_to_nineteen[self % 10]
    end
    # if self < 10
    #   zero_to_nine[self]
    # else
    #   ten_to_twelve[self % 10]
    # end
  end
end
