class UsersController < ApplicationController
	# Create new users with the following params
	# username: string
	# password: string
  	#
  	# renders: 
  	# 0 - success
  	# 1 - account username already exists
  	# 2 - error interacting with database
  	def signup        
		findUser = User.find_by(username: params[:username])

		if findUser == nil
			user = User.new(username: params[:username], password: params[:password])
            if user.save
				token = encode_token({user_id: user.id})
				render json: {status: 0, token: token}
			else
				render json: {status: 2, error: user.errors.messages}
			end
		else
			render json: {status: 1}
		end
	end

  # Log in with the following params
  # username: string
  # password: string
  # 
  # renders status:
  # 0 - success
  # 1 - username/password is wrong
  # 
  # On success also renders JWT
  def login
    user = User.find_by(username: params[:username])

	if user == nil
		render json: {status: 1}
	else
		if user['password'] == params[:password]
			token = encode_token({user_id: user.id})
			render json: {status: 0, token: token}
		else
			render json: {status: 1}
		end
	end
  end

  # Log in with the following params
  # token: string
  # 
  # renders status:
  # 0 - success
  # 1 - user does not exist
  # 
  # On success renders username
  def autoLogin
    user = authorised_user(params[:token])
        
    if user == nil
		render json: {status: 1}
	else
		render json: {status: 0, username: user.username}
	end
  end
end
