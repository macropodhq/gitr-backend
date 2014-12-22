class User < ActiveRecord::Base
  def generate_jwt
    JWT.encode({
                   user_id: id,
                   exp: 1.hour.from_now.to_i
               },
               ENV['JWT_SECRET_KEY']
    )
  end
end
