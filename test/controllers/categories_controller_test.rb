require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports")
    
    #this line is to simulate an admin that is going to test the category create functionality test 
    @user = User.create(username: "john", email: "john@email.com", password: "password", admin: true)
    
  end
  
  
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  
  test "should get new" do
    #this line(23) is to set the session of the user from line(9) which is an admin which lets the create/new functions work in the test properly
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  
  test "shoudl get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
  
end