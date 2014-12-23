class User < ActiveRecord::Base
  has_many :matches, dependent: :destroy
  has_many :messages, dependent: :destroy

  def generate_jwt
    JWT.encode({
                   user_id: id,
                   exp: 1.day.from_now.to_i
               },
               ENV['JWT_SECRET_KEY']
    )
  end

  def channel
    Digest::SHA1.hexdigest('PUBSUB_SALT' + id)
  end

  def push_message(message)
    pubnub = Pubnub.new(
        :publish_key => ENV['PUBNUB_PUBLISH_KEY'],
        :subscribe_key => ENV['PUBNUB_SUBSCRIBE_KEY']
    )

    pubnub.publish(
        :channel => channel,
        :message => message
    ) { |data| puts data.response }

  end
end
