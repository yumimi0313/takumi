require "test_helper"

class CraftmenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @craftman = craftmen(:one)
  end

  test "should get index" do
    get craftmen_url
    assert_response :success
  end

  test "should get new" do
    get new_craftman_url
    assert_response :success
  end

  test "should create craftman" do
    assert_difference('Craftman.count') do
      post craftmen_url, params: { craftman: { category: @craftman.category, company_name: @craftman.company_name, history: @craftman.history, image: @craftman.image, manicipal: @craftman.manicipal, prefecture: @craftman.prefecture, profile: @craftman.profile, recruit_content: @craftman.recruit_content, recruit_status: @craftman.recruit_status, recruit_title: @craftman.recruit_title, technology: @craftman.technology, user_id: @craftman.user_id } }
    end

    assert_redirected_to craftman_url(Craftman.last)
  end

  test "should show craftman" do
    get craftman_url(@craftman)
    assert_response :success
  end

  test "should get edit" do
    get edit_craftman_url(@craftman)
    assert_response :success
  end

  test "should update craftman" do
    patch craftman_url(@craftman), params: { craftman: { category: @craftman.category, company_name: @craftman.company_name, history: @craftman.history, image: @craftman.image, manicipal: @craftman.manicipal, prefecture: @craftman.prefecture, profile: @craftman.profile, recruit_content: @craftman.recruit_content, recruit_status: @craftman.recruit_status, recruit_title: @craftman.recruit_title, technology: @craftman.technology, user_id: @craftman.user_id } }
    assert_redirected_to craftman_url(@craftman)
  end

  test "should destroy craftman" do
    assert_difference('Craftman.count', -1) do
      delete craftman_url(@craftman)
    end

    assert_redirected_to craftmen_url
  end
end
