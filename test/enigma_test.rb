require 'simplecov'
SimpleCov.start
require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_starts_with_a_character_map
    expected = [*('a'..'z'), *('0'..'9'), ' ', '.',',']
    assert_equal expected, @enigma.character_map
  end

  def test_the_random_key_generator_generates_a_five_character_key
    assert_equal 5, @enigma.key_generator.length
  end

  def test_the_master_key_holder_with_given_key
    @enigma.encrypt("hello", "12345")
    assert_equal ["12", "23", "34", "45"], @enigma.key_holder
  end

  def test_the_last_four_method_with_hardcoded_date
    @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
    assert_equal "9124", @enigma.last_four
  end

  def test_can_turn_offset_into_integers
    @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
    assert_equal = [9, 1, 2, 4], @enigma.offset
  end

  def test_it_turns_key_array_into_integers
    @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
    assert_equal [12, 23, 34, 45], @enigma.key_array
  end

  def test_where_to_rotate_works
    @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
          expected = {
          "a" => (21),
          "b" => (24),
          "c" => (36),
          "d" => (49)
          }
    assert_equal expected, @enigma.where_to_rotate
  end

  def test_it_can_slice_message_into_fours
    @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
    require "pry"; binding.pry
    assert_equal ["h", "e", "l", "l"] ["o"], @enigma.slice_it
  end

  # def test_it_can_rotate_h_twenty_one_times
  #   @enigma.encrypt("hello", "12345", Date.new(2018, 8, 27))
  #
  #   assert_equal []
  # end

end
