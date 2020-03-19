class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username]) # The return value will be nil if that user can't be found, in which case the second conditional in the following line won't even be reached, which will prevent the NoMethodError that would otherwise result from "authenticate" being an undefined method for nil:nilClass.
    if @user && @user.authenticate(user_login_params[:password]) # The #authenticate method of User comes from BCrypt.
      token = encode_token({ user_id: @user.id }) # The encode_token method comes from ApplicationController. We call it with the argument of the found user's ID in a payload.
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted # The user data can then be stored in the application's state (Rails, for example, I think?), while the token can be stored client-side.
    else
      render json: {message: 'Invalid username or password' }, status: :unauthorized
    end
  end
  # The client should be sending a JWT (JSON Web token) along with every authenticated request. A sample request might look like:
  # fetch('http://localhost:3000/api/v1/profile', {
  # method: 'GET',
  # headers: {
  #   Authorization: `Bearer <token>`
  # }
# })

    private

    def user_login_params

      params.require(:user).permit(:username, :password)
    end
  end




# class Api::V1::AuthController < ApplicationController
#   skip_before_action :authorized, only: [:create]
#
#   def create
#     @user = User.find_by(username: user_login_params[:username])
#     #User#authenticate comes from BCrypt
#     if @user && @user.authenticate(user_login_params[:password])
#       # encode token comes from ApplicationController
#       token = encode_token({ user_id: @user.id })
#       render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
#     else
#       render json: { message: 'Invalid username or password' }, status: :unauthorized
#     end
#   end
#
#   private
#
#   def user_login_params
#     # params { user: {username: 'Chandler Bing', password: 'hi' } }
#     params.require(:user).permit(:username, :password)
#   end
# end
