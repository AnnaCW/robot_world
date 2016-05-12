require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest

  def test_user_sees_all_robots
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    visit '/robots'

    assert page.has_content?("Helen")
    assert page.has_content?("Harrison")
  end

end
