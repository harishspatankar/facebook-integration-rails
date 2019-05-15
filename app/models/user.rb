class User < ApplicationRecord

  USER_ACCESS_PERMISSIONS = ["email", "publish_stream"]
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.image_url        = auth.info.image
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
end
