# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'don\'t show logged in users the landing page' do
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
    get root_path
    assert_redirected_to profile_path
  end
end
