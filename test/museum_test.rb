require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/patron'
require 'pry'

class MuseumTest < Minitest::Test
  def test_it_exists
    museum = Museum.new("Denver Museum of Nature and Science")
    assert_instance_of Museum, museum
  end

  def test_it_has_attributes
    museum = Museum.new("Denver Museum of Nature and Science")
    assert_equal "Denver Museum of Nature and Science", museum.name
    assert_equal Hash.new, museum.exhibits
    assert_equal 0, museum.revenue
  end

  def test_it_can_add_exhibits
    museum = Museum.new("Denver")
    museum.add_exhibit("Gems and Minerals", 0)
    expected = {"Gems and Minerals" => 0}
    assert_equal expected, museum.exhibits
  end

  def test_it_can_admit_patrons
    museum = Museum.new("Denver")
    museum.add_exhibit("Gems and Minerals", 0)
    museum.add_exhibit("Dead Sea Scrolls", 10)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")

    jane = Patron.new("Jane")
    jane.add_interest("Dead Sea Scrolls")

    museum.admit(bob)
    museum.admit(jane)
    assert_equal 20, museum.revenue
  end

  def test_interests_without_exhibits_are_ignored
    museum = Museum.new("Denver")
    museum.add_exhibit("Gems and Minerals", 0)
    museum.add_exhibit("Dead Sea Scrolls", 10)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    museum.admit(bob)
    assert_equal 10, museum.revenue
  end

  def test_add_patron
    museum = Museum.new("Denver")
    bob = Patron.new("Bob")
    museum.add_patron("Dead Sea Scrolls", bob)

    expected = {"Dead Sea Scrolls" => [bob]}
    assert_equal expected, museum.patrons

    jane = Patron.new("Jane")
    museum.add_patron("Dead Sea Scrolls", jane)

    expected = {"Dead Sea Scrolls" => [bob, jane]}
    assert_equal expected, museum.patrons
  end

  def test_it_can_track_patrons_by_exhibit
    museum = Museum.new("Denver")
    museum.add_exhibit("Gems and Minerals", 0)
    museum.add_exhibit("Dead Sea Scrolls", 10)

    bob = Patron.new("Bob")
    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    jane = Patron.new("Jane")
    jane.add_interest("Dead Sea Scrolls")

    museum.admit(bob)
    museum.admit(jane)

    assert_equal ["Bob", "Jane"], museum.patrons_of("Dead Sea Scrolls")
    assert_equal ["Bob"], museum.patrons_of("Gems and Minerals")
  end
end
