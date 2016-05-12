require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest

  def test_user_sees_all_robots
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

    visit '/robots'

    assert page.has_content?(1)
    assert page.has_content?("Harrison")
  end

end
