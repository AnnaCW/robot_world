require_relative '../test_helper'

class UserCanCreateANewRobotTest < FeatureTest

  def test_user_creates_robot
    visit '/robots'

    click_link "New Robot"

    fill_in 'robot[name]', with: "Bob the Blob"
    fill_in 'robot[city]', with: "Lodi"
    click_button "Submit"

    assert page.has_content?("Bob the Blob")
  end

end
