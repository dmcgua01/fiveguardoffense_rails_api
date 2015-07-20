require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject { response }

  let!(:valid_user_object) {
    { first_name: "bob", last_name: "saget", email: "test@gmail.com", password: "full_house" }
  }
  let!(:invalid_user_object) { { api_key: "bar" } }
  let!(:admin_user) { FactoryGirl.create(:user, is_admin: true) }
  let!(:regular_user) { FactoryGirl.create(:user, is_admin: false) }

  #TODO: define these factories somewhere and use them because FactoryGirl does not work well with Mongoid
  # let!(:admin_user) { Mongoid::Factory.build(User, {
  #   "first_name" => "Joe",
  #   "last_name" => "Shmoe",
  #   "email" => "joe@gmail.com",
  #   "password" => "password",
  #   "api_key" => "api_key",
  #   "is_admin" => true
  # }) }

  # let!(:regular_user) { Mongoid::Factory.build(User, {
  #   "first_name" => "Joe",
  #   "last_name" => "Shmoe",
  #   "email" => "joe@gmail.com",
  #   "password" => "password",
  #   "api_key" => "api_key",
  #   "is_admin" => false
  # }) }

  let!(:invalid_user_object_response_body) { { status: "invalid request parameter: user.api_key" }.to_json }
  let!(:unauthorized_response_body) { { error: "unauthorized" }.to_json }
  let!(:not_found_response_body) { { error: "user not found" }.to_json }
  let!(:valid_user_id) { regular_user.id }
  let!(:invalid_user_id) { "#{regular_user.id}asdfqwerty" }
  let!(:user_path) { "/users/" }
  let!(:valid_user_path) { "#{user_path}#{valid_user_id}" }
  let!(:invalid_user_path) { "#{user_path}#{invalid_user_id}" }

  describe "POST /users" do

    context "with a valid admin api_key" do
      context "with a valid user object" do
        before { post users_path, user: valid_user_object, api_key: admin_user.api_key }

        it { is_expected.to have_http_status(:success) }
        it { expect(body).to match /"status":"created"/ }
        it { expect(body).to match /"first_name":"#{valid_user_object[:first_name]}"/ }
        it { expect(body).to match /"last_name":"#{valid_user_object[:last_name]}"/ }
        it { expect(body).to match /"email":"#{valid_user_object[:email]}"/ }

        #TODO: fix these tests
        xit { expect(body).not_to match /_id/ }
        xit { expect(body).not_to match /encrypted_email/ }
        xit { expect(body).not_to match /api_key/ }
        xit { expect(body).not_to match /password/ }
        xit { expect(body).not_to match /is_admin/ }
      end

      context "with an invalid user object" do
        before { post users_path, user: invalid_user_object, api_key: admin_user.api_key }

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(body).to eq invalid_user_object_response_body }
      end

      context "with no user object" do
        it { expect{ post users_path, api_key: admin_user.api_key }.to raise_error ActionController::ParameterMissing }
      end
    end

    context "with an invalid admin api key" do
      context "with a valid user object" do
        before { post users_path, user: valid_user_object, api_key: regular_user.api_key }

        it { is_expected.to have_http_status(:unauthorized) }
        it { expect(body).to eq unauthorized_response_body }
      end

      context "with an invalid user object" do
        before { post users_path, user: invalid_user_object, api_key: regular_user.api_key }

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(body).to eq invalid_user_object_response_body }
      end

      context "with no user object" do
        it { expect{ post users_path, api_key: regular_user.api_key }.to raise_error ActionController::ParameterMissing }
      end
    end

  end

  describe "GET /users/:id" do

    context "with a valid id" do
      context "with a valid api key" do
        before { get valid_user_path, api_key: regular_user.api_key }

        it { is_expected.to have_http_status(:success) }

        it { expect(body).to match /"first_name":"#{regular_user.first_name}"/ }
        it { expect(body).to match /"last_name":"#{regular_user.last_name}"/ }
        it { expect(body).to match /"email":"#{regular_user.email}"/ }
        xit { expect(body).not_to match /_id/ } #TODO: fix this test
        it { expect(body).not_to match /encrypted_email/ }
        it { expect(body).not_to match /api_key/ }
        it { expect(body).not_to match /password/ }
        it { expect(body).not_to match /is_admin/ }
      end

      context "with an invalid api key" do
        before { get valid_user_path, api_key: admin_user.api_key }

        it { is_expected.to have_http_status(:unauthorized) }
        it { expect(body).to eq unauthorized_response_body }
      end

      context "with no api key" do
        it { expect{ get valid_user_path }.to raise_error ActionController::ParameterMissing }
      end
    end

    context "with an invalid id" do
      before { get invalid_user_path, api_key: regular_user.api_key }

      it { is_expected.to have_http_status(:not_found) }
      it { expect(body).to eq not_found_response_body }
    end

    context "with no id" do
      it { expect{ get user_path, api_key: regular_user.api_key }.to raise_error ActionController::RoutingError }
    end

  end

  describe "PATCH /users/:id" do
    #TODO: write these tests
  end

  describe "PUT /users/:id" do
    #TODO: write these tests
  end

  describe "DELETE /users/:id" do
    #TODO: write these tests
  end

end
