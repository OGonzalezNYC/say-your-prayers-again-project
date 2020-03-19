class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    # example:  payload => { beef: 'steak' }
    JWT.encode(payload, 'mys3cr3t')
    # example: jwt string: "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
  end
  # The JWT (JSON WEB TOKEN), according to its documentation, will typically be sent IN REQUEST HEADERS, such as:
#   fetch('http://localhost:3000/api/v1/profile', {
#   method: 'GET',
#   headers: {
#     Authorization: `Bearer <token>`
#     }
#   })
   # So instead of sending it directly to the decoded_token function, we send it to the auth_header function:
  def auth_header
    # "headers" is a property of the RubyOnRails "request" object.  It will return a hash containing all the headers assocated with the "request", in the case of JWT, typically:
    # { 'Authorization': 'Bearer <token>' }
    # So headers.['Authorization'] will yield a string that will we will pass to the decoded_token method, as the string contains the token.
    request.headers['Authorization']
  end

  def decoded_token#(does NOT take an argument of token)
    # example: # token => "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
    if auth_header # the function immediately above this one.
      # auth_header has returned the string, 'Bearer <token>', which was value of the 'Authorization' (, the only) key in the request.headers object, { 'Authorization': 'Bearer <token>' }.
      token = auth_header.split(" ")[1] # Turns the string 'Bearer <token>' into an array of strings, ["Bearer", "<token>"], and returns the second element in that array.
      begin # From the Ruby docs for the BEGIN keyword: BEGIN : Designates, via code block, code to be executed unconditionally before sequential execution of the program begins. Sometimes used to simulate forward references to methods.
        JWT.decode(token, 'mys3cr3t', true, algorithm: 'HS256')
        # example: # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }] I think the algorithm is an optional arg.
        # THIS SHOULD RESULT IN SOMETHING ALONFG THE LINES OF [{"user_id"=>2}, {"alg"=>"HS256"}] .
      rescue JWT::DecodeError #"rescue" is the Ruby keyword for handling exceptions. You should try to be specific about what exception you’re rescuing because it’s considered a bad practice to capture all exceptions. It prevents the server from crashing.
        # Not exactly sure what JWT::DecodeError does, except that it's a rescue technique for dealing with errors; I assume it decodes them.
        nil #When you use the expression rescue "nil", it will rescue from any kind of exception. Even if you have syntax error or any kind of error in the block from which it’s rescued. This violates the rule-of-thumb that it's a bad practice to capture ALL exceptions.
      end

    end

  end

  def current_user
    if decoded_token
      # decoded_token=> [{"user_id"=>2}, {"alg"=>"HS256"}]
      # or nil if we can't decode the token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      # returns the current user if the token could be decoded.
    end
  end

    def logged_in?
      !!current_user #Without any exclamation points, logged_in? would simply return the value of the immediately-above method, current_user.  A single exclamation point turns the return value into a boolean. And a double exclamation point turns it into an accurate boolean. So, basically, if there's IS a current_user, then logged_in? will return a value of true. And if there isn't a current_user, then logged_in will return false.
    end

    def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
      # This prevents unauthorized access.
      # "before_action :authorized" at the top of this class, outside of all the methods will call the authorized method before anything else happens in the app. This will effectively lock down the entire application. So we need to skip it at the top of the Users_Controller in order to allow the CREATION of a user. (A non-existent user can't logically be expected to log in; and UserController inherits from this ApplicationController).
    end
end







# class ApplicationController < ActionController::API
#   before_action :authorized
#
#   def encode_token(payload)
#     # should store secret in env variable
#     JWT.encode(payload, 'my_s3cr3t')
#   end
#
#   def auth_header
#     # { Authorization: 'Bearer <token>' }
#     request.headers['Authorization']
#   end
#
#   def decoded_token
#     if auth_header
#       token = auth_header.split(' ')[1]
#       # header: { 'Authorization': 'Bearer <token>' }
#       begin
#         JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
#       rescue JWT::DecodeError
#         nil
#       end
#     end
#   end
#
#   def current_user
#     if decoded_token
#       user_id = decoded_token[0]['user_id']
#       @user = User.find_by(id: user_id)
#     end
#   end
#
#   def logged_in?
#     !!current_user
#   end
#
#   def authorized
#     render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
#   end
# end
