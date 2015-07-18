class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    user = authenticate(request.request_parameters["PASSWORD"])

    render json: user.api_key
  end
end
