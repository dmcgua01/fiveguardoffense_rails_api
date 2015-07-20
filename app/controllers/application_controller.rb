class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_default_response_format

  def api_key_params
    params.require(:api_key)
  end

  def admin?(api_key)
    User.all.select{ |user| user.has_api_key?(api_key) and user.admin? }.any?
  end

  def authorized?(api_key, id)
    User.all.select{ |user| user.has_api_key?(api_key) and user.id.to_s.eql? id }.any?
  end

  private

  def set_default_response_format
    request.format = :json
  end

  #returns user object matching the password
  #returns nil if no match
  def authenticate(password)
    User.all.select{ |user| user.authenticated?(password) }.first
  end

end
