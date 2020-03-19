class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  # Allows the User#create method to skip the "before_action :authorized" coming from the ApplicationController; otherwise, the "Application#authorized" method would be run, and, with nobody logged in, it would lock down the whole app before a  user could even be created.
  def profile # bear in mind that Application Controller calls #authorized before any other controller methods are called. So if authorization fails, #profile will never be called; instead there will be: "render json: {message: 'Please log in'}, status: unauthorized".
    # THAT'S IT FOR THE SERVER!
    render json: {user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token({user_id: @user.id})
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created #instead of "200".
    else
      render json: { error: 'failed to create user'}, status: :not_acceptable # instead of "500".
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end






# class Api::V1::UsersController < ApplicationController
#   skip_before_action :authorized, only: [:create]
#
#   def profile
#     render json: { user: UserSerializer.new(current_user) }, status: :accepted
#   end
#
#   def create
#     @user = User.create(user_params)
#     if @user.valid?
#       @token = encode_token({ user_id: @user.id })
#       render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
#     else
#       render json: { error: 'failed to create user' }, status: :not_acceptable
#     end
#   end
#
#   private
#
#   def user_params
#     params.require(:user).permit(:username, :password) #, :bio, :avatar)
#   end
# end
