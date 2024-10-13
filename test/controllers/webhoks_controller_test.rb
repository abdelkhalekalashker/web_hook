require "test_helper"

class WebhoksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @webhok = webhoks(:one)
  end

  test "should get index" do
    get webhoks_url, as: :json
    assert_response :success
  end

  test "should create webhok" do
    assert_difference("Webhok.count") do
      post webhoks_url, params: { webhok: { url: @webhok.url, users_id: @webhok.users_id } }, as: :json
    end

    assert_response :created
  end

  test "should show webhok" do
    get webhok_url(@webhok), as: :json
    assert_response :success
  end

  test "should update webhok" do
    patch webhok_url(@webhok), params: { webhok: { url: @webhok.url, users_id: @webhok.users_id } }, as: :json
    assert_response :success
  end

  test "should destroy webhok" do
    assert_difference("Webhok.count", -1) do
      delete webhok_url(@webhok), as: :json
    end

    assert_response :no_content
  end
end
