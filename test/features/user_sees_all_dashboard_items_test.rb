require_relative '../test_helper'

class UserSeesAllDashboardItemsTest < FeatureTest

  def test_user_sees_all_dashboard_items
    robot_repository.create({name: "Harrison", city: "Portland", state: "Oregon", birthdate: "1981/10/20", date_hired: "2015/01/23", department: "Human Resources"})
    robot_repository.create({name: "Helen", city: "Dallas", state: "Texas", birthdate: "1990/09/20", date_hired: "2014/01/23", department: "Special Operations"})

    visit '/'

    assert page.has_content?("Texas")
    assert page.has_content?("Portland")
    assert page.has_content?(31)
    assert page.has_content?(2014)
    assert page.has_content?("Human Resources")
  end

end
