class Authentication < ActiveRecord::Base

  attr_accessible :provider, :uid

  belongs_to :user
  belongs_to :identity, foreign_key: "uid"

  validates :provider, :presence => true
  validates :uid, :presence => true

  def self.find_or_create_from_hash(auth_hash)
    auth = self.where(:provider => auth_hash['provider'], :uid => auth_hash['uid']).first \
           || self.create(:provider => auth_hash['provider'], :uid => auth_hash['uid'])

    if auth.user.nil?
      user = auth.build_user
      user.name = auth_hash['info']['name']
      if auth_hash['info']['image'].present? 
        user.remote_image_url = auth_hash['info']['image']
      elsif auth_hash['info']['email']
        user.remote_image_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(auth_hash['info']['email'])}?d=404" rescue nil
      end 
      user.save!
      auth.save
    end
    auth
  end

end