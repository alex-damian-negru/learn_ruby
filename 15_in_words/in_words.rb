require 'number_formatter'

Fixnum.class_eval do
  def in_words
    NumberFormatter.new(self).to_s
  end
end
