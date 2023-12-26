class ApplicationController < ActionController::API
    def encode_token(payload)
		JWT.encode(payload, 'secretkey')
	end

	def decode_token(token)
		begin
			JWT.decode(token, 'secretkey', true, algorithm: 'HS256')
		rescue JWT::DecodeError
			nil
		end
	end

	def authorised_user(token)
		user_id = decode_token(token)
		if user_id != nil
			user = User.find_by(id: user_id)
		else
			nil
		end
	end
end
