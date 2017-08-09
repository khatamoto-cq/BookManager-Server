class Api::V1::UsersController < Api::V1::ApiBaseController

  def create
    @user = User.new(user_params)
    @user.password_digest = BCrypt::Password.create(user_params[:password])
    if @user.save
      @user.reload
      render json: auth_token, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def auth_token
      Knock::AuthToken.new payload: { sub: @user.id }
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end