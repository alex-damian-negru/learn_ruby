Fixnum.class_eval do
  def in_words
    zero_to_nine = [
      "zero", "one", "two", "three", "four", 
      "five", "six", "seven", "eight", "nine"
    ]
    ten_to_twelve = ["ten", "eleven", "twelve"]

    if self < 10
      zero_to_nine[self]
    else
      ten_to_twelve[self % 10]
    end
  end
end
