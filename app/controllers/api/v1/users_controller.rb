class Api::V1::UsersController < Api::V1::ApiBaseController

  def create
    @user = User.new(email: user_params[:email], password: user_params[:password])
    if @user.save
      render json: auth_token, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def auth_token
      @user.reload
      Knock::AuthToken.new payload: { sub: @user.id }
    end

    def user_params
      params.permit(:email, :password)
    end
end