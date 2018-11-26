Fixnum.class_eval do
  def in_words
    zero_to_nine = [
      "zero", "one", "two", "three", "four", 
      "five", "six", "seven", "eight", "nine"
    ]
    zero_to_nine[self]
  end
end
