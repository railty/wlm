require 'test_helper'

class JobsControllerTest < ActionController::TestCase

  test "upload daily report" do
    post :upload_excel, excel: fixture_file_upload('hwadiwa_455472293_C15EDC7DXB3E9X402DXB164X91C98F856D85.xls', 'application/vnd.ms-excel')
    assert_redirected_to jobs_path
  end
end
