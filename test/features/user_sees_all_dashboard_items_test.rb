require_relative '../test_helper'

class UserSeesAllDashboardItemsTest < FeatureTest

  def test_user_sees_all_dashboard_items
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", avatar: "Zoron", birthdate: "10/20/1981", date_hired: "01/23/2015", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", avatar: "Boron", birthdate: "9/20/1990", date_hired: "01/23/2014", department: "Special Operations"})

    visit '/'

    assert page.has_content?("Texas")
    assert page.has_content?("Portland")
    assert page.has_content?(31)
    assert page.has_content?(2014)
    assert page.has_content?("Human Resources")
  end

end
