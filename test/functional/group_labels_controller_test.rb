require 'test_helper'

class GroupLabelsControllerTest < ActionController::TestCase
  setup do
    @group_label = group_labels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_labels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_label" do
    assert_difference('GroupLabel.count') do
      post :create, group_label: { label: @group_label.label, name: @group_label.name }
    end

    assert_redirected_to group_label_path(assigns(:group_label))
  end

  test "should show group_label" do
    get :show, id: @group_label
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_label
    assert_response :success
  end

  test "should update group_label" do
    put :update, id: @group_label, group_label: { label: @group_label.label, name: @group_label.name }
    assert_redirected_to group_label_path(assigns(:group_label))
  end

  test "should destroy group_label" do
    assert_difference('GroupLabel.count', -1) do
      delete :destroy, id: @group_label
    end

    assert_redirected_to group_labels_path
  end
end
