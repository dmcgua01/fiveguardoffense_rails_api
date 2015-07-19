class LoginController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def login
    user = authenticate(login_params)
    @api_key = user.api_key if user

    render json: { error: "unauthorized" }, status: :not_found if @api_key.nil?
  end

  private

  def login_params
    params.require(:password)
  end
end
