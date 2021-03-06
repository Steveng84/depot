ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  def login_as[:user_id] = users(user).user_id
  	session[:user_id] = users(user).id 
  end

  def logout
  	session.delete :user_id
  end
 
  def setup
  	login_as :one if defined? session
  end
  # Add more helper methods to be used by all tests here...
end
