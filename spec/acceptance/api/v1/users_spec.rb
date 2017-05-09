require 'rspec_api_documentation/dsl'

resource 'User', :type => :api do
  let(:user) { FactoryGirl.build :user_with_token }
  let(:admin_user) { FactoryGirl.build :user_with_token, :admin }

  post '/api/v1/users', format: :json do
    parameter :name, 'Name', required: true, scope: :user
    parameter :email, 'Email', required: true, scope: :user
    parameter :password, 'Password', required: true, scope: :user

    let(:name) { user.name }
    let(:email) { user.email }
    let(:password) { user.password }

    example_request 'sign up' do
      response_json = JSON.parse response_body

      expect(status).to eq(201)
      expect(response_json['user_token']).to have_key('access_token')
      expect(response_json['user_token']).to have_key('user')
    end

    example 'sign up error', document: false do
      do_request params.tap { |parameters| parameters['user']['email'] = nil }
      response_json = JSON.parse response_body

      expect(status).to eq(422)
      expect(response_json['errors']).to have_key('email')
    end
  end

  post '/api/v1/users/forgot_password', format: :json do
    before { user.save }

    parameter :email, 'Email', required: true, scope: :user
    let(:email) { user.email }

    example_request 'forgot password' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['user']['email']).to eq(email)
    end
  end

  put '/api/v1/users/reset_password', format: :json do
    before { user.save }

    parameter :reset_password_token, 'Reset password token', required: true, scope: :user
    parameter :password, 'Password', required: true, scope: :user
    parameter :password_confirmation, 'Password confirmation', required: true, scope: :user

    let(:reset_password_token) { user.send :set_reset_password_token }
    let(:password) { Faker::Internet.password 8 }
    let(:password_confirmation) { password }

    example_request 'reset password' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['user']).to have_key('id')
    end
  end

  get '/api/v1/users', format: :json do
    before { user.save }

    header 'AUTHORIZATION', :token

    parameter :id, 'User Unique Identifier', required: true

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:id) { user.id }

    example_request 'index' do
      response_json = JSON.parse response_body
      # normal user isn't authorized to list users
      expect(status).to eq 401
    end
  end

  get '/api/v1/users', format: :json do
    before { admin_user.save }

    header 'AUTHORIZATION', :token

    parameter :id, 'User Unique Identifier', required: true

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials admin_user.user_tokens.first.try(:access_token) }
    let(:id) { admin_user.id }

    example_request 'index' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json).to have_key('users')
      expect(response_json["users"].count).to eq User.count
    end
  end

  get '/api/v1/users/:id', format: :json do
    before { user.save }

    header 'AUTHORIZATION', :token

    parameter :id, 'User Unique Identifier', required: true

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:id) { user.id }

    example_request 'show' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['user']).to have_key('id')
    end
  end

  put '/api/v1/users/:id', format: :json do
    before { user.save }

    header 'AUTHORIZATION', :token

    parameter :id, 'User Unique Identifier', required: true
    parameter :name, 'Updated Name', scope: :user    

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:id) { user.id }
    let(:name) { new_name }
    let(:old_name) { user.name }
    let(:new_name) { user.name + ' Updated' }

    example_request 'update' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['user']).to have_key('id')

      updated_user = User.find(response_json['user']['id'])

      expect(response_json['user']).to have_key('name')
      # make sure the returned value is correct
      expect(response_json['user']['name']).to eq new_name
      # make sure the saved value is correct
      expect(updated_user.name).to eq new_name
      expect(updated_user.name).not_to eq old_name
    end
  end
end
