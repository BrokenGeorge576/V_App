require "test_helper"

class ManagedFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get managed_files_index_url
    assert_response :success
  end
end
