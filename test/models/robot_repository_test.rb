require_relative '../test_helper'

class RobotRepositoryTest < Minitest::Test
  include TestHelpers

  def setup
    robot_repository.create({
      id: 1,
      name: "Harrison",
      city: "Portland",
      state: "Oregon",
      avatar: "Zoron",
      birthdate: "10/20/1981",
      date_hired: "01/23/2015",
      department: "Human Resources"
      })
      robot_repository.create({
        id: 2,
        name: "Helen",
        city: "Dallas",
        state: "Texas",
        avatar: "Boron",
        birthdate: "9/20/1990",
        date_hired: "01/23/2014",
        department: "Special Operations"
        })
      end

  def test_it_creates_a_robot
    robots = robot_repository.all

    assert_equal 2, robots.count
    assert_equal "Portland", robots.first.city
  end

  def test_it_finds_all_robots
    robots = robot_repository.all

    assert_equal 2, robots.count
    assert_equal "Oregon", robots.first.state
  end

  def test_it_finds_a_single_robot
    robot = robot_repository.find(2)
    assert_equal "Helen", robot.name
  end

  def test_it_updates_a_robot
    robot_repository.update(1, {city: "Denver"})
    assert_equal "Denver", robot_repository.find(1).city
  end

  def test_it_destroys_a_robot
    robot_repository.destroy(2)
    assert_equal 1, robot_repository.all.count
  end


end
