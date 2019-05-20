class User < ApplicationRecord

  has_many :pages

  USER_ACCESS_PERMISSIONS = ["email", "publish_pages", "manage_pages"]
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.image_url        = auth.info.image
      user.oauth_token      = auth.credentials.token
      # user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def page(page_access_token)
    @page ||= Koala::Facebook::API.new(page_access_token)
  end

  def get_all_pages
    @all_pages ||= facebook.get_connections('me','accounts')
  end

  def get_page_access_token(page_id)
    @page_access_token ||= facebook.get_page_access_token(page_id)
  end
end
