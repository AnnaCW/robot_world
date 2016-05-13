require_relative '../test_helper'

class RobotStatisticsTest < Minitest::Test
  include TestHelpers
  attr_reader :statistics

  def setup
    table = robot_repository.table
    @statistics = RobotStatistics.new(table)
  end

  def test_it_finds_robot_birthdates
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal ["9/20/1990"], statistics.birthdates
  end

  def test_it_finds_average_age
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal 31, statistics.average_age
  end

  def test_it_finds_robots_hired_per_year
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal [["2014", 1], ["2015", 1]], statistics.robots_hired_per_year.sort
  end

  def test_it_finds_robot_cities
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal ["Portland", "Dallas"], statistics.robot_cities
  end

  def test_it_finds_robots_per_city
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal [["Portland", 1], ["Dallas", 1]], statistics.robots_per_city
  end

  def test_it_finds_robots_per_state
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal [["Oregon", 1], ["Texas", 1]], statistics.robots_per_state
  end

  def test_it_finds_robots_per_department
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    assert_equal [["Human Resources", 1], ["Special Operations", 1]], statistics.robots_per_department
  end

end
