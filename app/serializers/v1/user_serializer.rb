require 'authorization'

class V1::UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id
  attributes :email
  attributes :username
  attributes :fb_user_id
  attributes :password_digest
  attributes :created_at
  attributes :updated_at
  
  has_many :tokens
  

  def include_id?
    return ::Authorization::V1::User.include_id?(current_user,object,@options)
  end

  def include_email?
    return ::Authorization::V1::User.include_email?(current_user,object,@options)
  end

  def include_username?
    return ::Authorization::V1::User.include_username?(current_user,object,@options)
  end

  def include_fb_user_id?
    return ::Authorization::V1::User.include_fb_user_id?(current_user,object,@options)
  end

  def include_password_digest?
    return ::Authorization::V1::User.include_password_digest?(current_user,object,@options)
  end

  def include_created_at?
    return ::Authorization::V1::User.include_created_at?(current_user,object,@options)
  end

  def include_updated_at?
    return ::Authorization::V1::User.include_updated_at?(current_user,object,@options)
  end

  def include_associations!
    include! :tokens if ::Authorization::V1::User.include_tokens?(current_user,object,@options)
  end

end