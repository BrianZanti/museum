require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'

class PatronTest < Minitest::Test
  def test_it_exists
    patron = Patron.new("Bob")
    assert_instance_of Patron, patron
  end

  def test_it_has_attributes
    patron = Patron.new("Bob")
    assert_equal "Bob", patron.name
    assert_equal [], patron.interests
  end

  def test_it_can_add_interests
    patron = Patron.new("Bob")
    patron.add_interest("Imax")
    patron.add_interest("Gems and Minerals")
    assert_equal ["Imax", "Gems and Minerals"], patron.interests
  end
end
