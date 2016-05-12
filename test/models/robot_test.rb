require_relative '../test_helper'

class RobotTest < Minitest::Test

  def test_it_assigns_attributes_correctly
    robot = Robot.new(
      {
      :id => 1,
      :name => "Harrison",
      :city => "Portland",
      :state => "Oregon",
      :avatar => "Zoron",
      :birthdate => "10/20/1981",
      :date_hired => "01/23/2015",
      :department => "Special Operations"
      })

    assert_equal "Harrison", robot.name
    assert_equal "Portland", robot.city
    assert_equal 1, robot.id
  end


end
