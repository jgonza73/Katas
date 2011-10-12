#!/usr/bin/env ruby
require "test/unit"
require_relative "string_calculator"


class TestStringCalculatorAdd < Test::Unit::TestCase
  
  def setup
    @string_calculator = StringCalculator.new(InputParser.new, InputValidator.new)
  end
  
  def test_empty_string_we_get_0
    assert_equal 0, @string_calculator.add("")
  end
  
  def test_1_we_get_1
    assert_equal 1, @string_calculator.add("1")
  end
  
  def test_2_we_get_2
    assert_equal 2, @string_calculator.add("2")
  end
  
  def test_with_1_and_2_we_get_3
    assert_equal 3, @string_calculator.add("1,2")
  end
  
  def test_with_2_and_4_we_get_6
    assert_equal 6, @string_calculator.add("2,4")
  end
  
  def test_with_1_newline_2_3_we_get_6
    assert_equal 6, @string_calculator.add("1\n2,3")
  end
  
  def test_with_delimiter_semicolon_1_and_2_we_get_3
    assert_equal 3, @string_calculator.add("//;\n1;2")
  end
  
  def test_with_minus_one_semicolon_and_two_a_exception_is_raised
    exception = assert_raises(RuntimeError) { @string_calculator.add("-1,2") }
    assert_equal "negatives not allowed: -1", exception.message
  end
  
  def test_with_minus_one_semicolon_minus_two_a_exception_is_raised
    exception = assert_raises(RuntimeError) { @string_calculator.add("-1, -2") }
    assert_equal "negatives not allowed: -1, -2", exception.message
  end
end