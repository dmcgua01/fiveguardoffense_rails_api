require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let!(:user) { FactoryGirl.create :user }

  before do
    assign :user, user
    render
  end

  it "should return json" do
    expect{ JSON.parse(rendered) }.not_to raise_error
  end

  it "renders the api key" do
    expected_response = {
      _id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    }.to_json

    expect(rendered).to eq expected_response
  end
  
end
