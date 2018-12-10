class NumberFormatter
  ZERO = 'zero'.freeze
  HUNDRED = 'hundred'.freeze
  GROUPS = {
    "trillion" => 10**12,
    "billion" => 10**9,
    "million" => 10**6,
    "thousand" => 10**3,
    '' => 10**0
  }.freeze
  ZERO_TO_NINETEEN = ["", "one", "two", "three", "four", 
    "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", 
    "fourteen", "fifteen", "sixteen", 
    "seventeen", "eighteen", "nineteen"
  ].freeze
  TENS = ["", "ten", "twenty", "thirty", "forty", 
    "fifty", "sixty", "seventy", "eighty", "ninety"
  ].freeze

  def initialize(number)
    @number = number
  end

  def to_s
    return ZERO if @number.zero?

    GROUPS.map { |group_suffix, multiplier| format_group(@number,  multiplier, group_suffix) }
      .flatten
      .reject(&:empty?)
      .join(' ')
  end

  private

  def format_number(n)
    return ZERO_TO_NINETEEN[n] if n < 20
    TENS[n / 10] + (n % 10 == 0 ? "" : " " + ZERO_TO_NINETEEN[n % 10]) 
  end

  def format_group(n, group_multiplier, group_suffix)
    tokens = []
    group = n / group_multiplier % 1000
    hundreds = group / 100
    tens = group % 100

    if hundreds > 0
      tokens << format_number(hundreds)
      tokens << HUNDRED
    end

    if tens > 0
      tokens << format_number(tens)
    end

    if group > 0
      tokens << group_suffix
    end

    tokens
  end
end