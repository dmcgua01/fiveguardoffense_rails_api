require 'rails_helper'

RSpec.describe "login/login", type: :view do
  let!(:user) { FactoryGirl.create :user }

  before do
    assign :api_key, user.api_key
    render
  end

  it "should return json" do
    expect{ JSON.parse(rendered) }.not_to raise_error
  end

  it "renders the api key" do
    expected_response = {
      api_key: user.api_key
    }.to_json

    expect(rendered).to eq expected_response
  end
end
