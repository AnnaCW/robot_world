require_relative '../test_helper'

class RobotRepositoryTest < Minitest::Test
  include TestHelpers


  def test_it_creates_a_robot
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal 2, robot_repository.all.count
    assert_equal "Portland", robot_repository.all.first.city
  end

  def test_it_finds_all_robots
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal 2, robot_repository.all.count
    assert_equal "Oregon", robot_repository.all.first.state
  end

  def test_it_finds_a_single_robot
    robot_id = robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})
    robot = robot_repository.find(robot_id)
    assert_equal "Helen", robot.name
  end

  def test_it_updates_a_robot
    robot_id = robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.update(robot_id, {city: "Denver"})

    assert_equal "Denver", robot_repository.find(robot_id).city
  end

  def test_it_destroys_a_robot
    robot_id = robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})
    robot_repository.destroy(robot_id)

    assert_equal 0, robot_repository.all.count
  end

end
