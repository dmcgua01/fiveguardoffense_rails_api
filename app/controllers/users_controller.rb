class UsersController < ApplicationController
  respond_to :json
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /users/1
  # GET /users/1.json
  def show
    render json: { error: "user not found" }, status: :not_found if not @user
  end

  # POST /users
  # POST /users.json
  def create
    if not admin?(admin_params)
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
    if not admin?(admin_params)
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
        render json: { error: "unauthorized" }, status: :unauthorized if not @user or not @user.api_key.eql? params["api_key"]
      rescue Mongoid::Errors::DocumentNotFound
        @user = nil
      end
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
