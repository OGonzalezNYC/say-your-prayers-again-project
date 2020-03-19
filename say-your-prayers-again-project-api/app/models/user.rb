class User < ApplicationRecord
  has_secure_password # this allows use of Active Record's
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  # validates :username, uniqueness: true # { case_sensitive: false }
  # has_secure_password, above, eliminates the need for password validation. And, obviously, a password doesn't need to be unique.
  has_many :prayers
  # authenticate(password) (with bcrypt) verify that a user is using the right password. For example, in the rails console, if I run "dave = User.new(username: 'Dave', password: 'DavePassword')", and then run "dave.save", then "dave.authenticate('X')" will return false, but "dave.authenticate('DavePassword')" will return a hash with his id, username, password_DIGEST (lower case) and timestamps.
end
