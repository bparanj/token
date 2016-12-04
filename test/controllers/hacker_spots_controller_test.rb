require 'test_helper'

class HackerSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hacker_spots_index_url
    assert_response :success
  end

end
