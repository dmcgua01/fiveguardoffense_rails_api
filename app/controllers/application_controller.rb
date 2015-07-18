class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #returns user object matching the password
  #returns nil if no match
  def authenticate(password)
    User.all.select{ |user| user.authenticated?(password) }.first
  end
end
