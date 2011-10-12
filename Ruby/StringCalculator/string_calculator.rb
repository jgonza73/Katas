class StringCalculator
  attr_reader :input_parser, :input_validator
  
  def initialize(input_parser, input_validator)
    @input_parser = input_parser
    @input_validator = input_validator
  end
  
  def add(input)
    numbers = @input_parser.extract_numbers input
    @input_validator.validate numbers
    numbers.inject(0) { |sum, value| sum + value }
  end
  
end

class InputParser
  DELIMITER_IDENTIFICATOR = "//"
  NUMBER_POSITION = 4
  DELIMITER_POSITION = 2
  
  def extract_numbers(input)
    delimiter_expression, numbers_string = decompose input
    return numbers_string.split(delimiter_expression).map(&:to_i)
  end
  
  private
  def decompose input
    if input.start_with? DELIMITER_IDENTIFICATOR
      return [/#{input[DELIMITER_POSITION]}/, input[NUMBER_POSITION..input.size]]
    end
    return [/\n|,/, input]
  end
  
end

class InputValidator
  NEGATIVES_EXCEPTION = "negatives not allowed: "
  NEGATIVES_SEPARATOR = ', '
  
  def validate numbers
    negative_numbers = numbers.select {|number| number < 0}
    if !negative_numbers.empty?
      raise NEGATIVES_EXCEPTION + "#{negative_numbers.join NEGATIVES_SEPARATOR}"
    end
  end
  
end