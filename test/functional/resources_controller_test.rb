require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  setup do
    @resource = resources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource" do
    assert_difference('Resource.count') do
      post :create, resource: { clean_url: @resource.clean_url, description: @resource.description, keywords_manual: @resource.keywords_manual, keywords_scraped: @resource.keywords_scraped, raw_url: @resource.raw_url, title_manual: @resource.title_manual, title_scraped: @resource.title_scraped, user_id: @resource.user_id }
    end

    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should show resource" do
    get :show, id: @resource
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resource
    assert_response :success
  end

  test "should update resource" do
    put :update, id: @resource, resource: { clean_url: @resource.clean_url, description: @resource.description, keywords_manual: @resource.keywords_manual, keywords_scraped: @resource.keywords_scraped, raw_url: @resource.raw_url, title_manual: @resource.title_manual, title_scraped: @resource.title_scraped, user_id: @resource.user_id }
    assert_redirected_to resource_path(assigns(:resource))
  end

  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @resource
    end

    assert_redirected_to resources_path
  end
end
