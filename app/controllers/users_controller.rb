class UsersController < ApplicationController
  respond_to :json
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /users/1
  # GET /users/1.json
  def show
    #TODO: make this a before action, but after set_user
    if not @user
      render json: { error: "user not found" }, status: :not_found
      return
    end

    #TODO: make this a before action, but after set_user
    if not authorized?(api_key_params, params[:id])
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end
  end

  # POST /users
  # POST /users.json
  def create
    #TODO: make this a before_action
    user_params #check for required parameters before any other validations

    #TODO: make this a before_action
    if params[:user] and params[:user].include? "api_key"
      render json: { status: "invalid request parameter: user.api_key" }, status: :bad_request
      return
    end

    #TODO: make this a before_action
    if not admin?(api_key_params)
      render json: { error: "unauthorized"}, status: :unauthorized
      return
    end

    @user = User.new(user_params)

    if @user.save
      render json: { status: :created, user: @user }
    else
      render json: { status: :unprocessable_entity, errors: @user.errors }
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #TODO: make this a before action, but after set_user
    if not @user
      render json: { error: "user not found" }, status: :not_found
      return
    end

    #TODO: make this a before action, but after set_user
    if not authorized?(api_key_params, params[:id])
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end

    #TODO: make this a before_action
    user_params #check for required parameters before any other validations

    #TODO: make this a before_action
    if not authorized?(api_key_params)
      render json: { error: "unauthorized"}, status: :unauthorized
      return
    end

    #TODO: make this a before_action
    if params[:user] and params[:user].include? "api_key"
      render json: { status: "invalid request parameter: user.api_key" }, status: :bad_request
      return
    end

    if @user.update(user_params)
      render json: { status: "user updated successfully" }, status: :ok, location: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #TODO: need to finish testing this. admin check might not work for delete
  #requests
  def destroy
    #TODO: make this a before action, but after set_user
    if not @user
      render json: { error: "user not found" }, status: :not_found
      return
    end

    #TODO: make this a before action, but after set_user
    if not authorized?(api_key_params, params[:id])
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end

    #TODO: finish writing the rest of this message
    if not admin?(api_key_params)
      render json: { error: "unauthorized"}, status: :unauthorized
      return
    end

    @user.destroy

    render json: { status: "user was successfully deleted" }
  end

  private

  def set_user
    begin
      @user = User.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      @user = nil
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
