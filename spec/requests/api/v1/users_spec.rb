require 'rails_helper'

describe 'Users API', type: :request do

  describe "POST /api/v1/signup" do
    context "正常系" do
      it "registers a user with email and password." do
        post_attributes = {
          email: 'hoge@caraquri.com',
          password: 'caraquri1234'
        }
        post api_v1_sign_up_path, params: post_attributes.to_json, headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response).to be_success
        json_response = JSON.parse(response.body)
        expect(json_response['jwt']).not_to be_empty
      end
    end

    context "異常系" do
      it "can't registers a user without email or password." do
        post_attributes = {
          email: 'hoge@caraquri.com',
          password: nil
        }
        post api_v1_sign_up_path, params: post_attributes.to_json, headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response).not_to be_success

        post_attributes = {
          email: nil,
          password: 'caraquri1234'
        }
        post api_v1_sign_up_path, params: post_attributes.to_json, headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response).not_to be_success
      end
    end
  end
end
