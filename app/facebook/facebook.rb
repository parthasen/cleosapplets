require 'httparty'

class Facebook
	include ::HTTParty
	base_uri 'https://graph.facebook.com/v2.1'
	#format :json
	#debug_output $stdout

  def initialize()
  end

  def get_long_token(short_token)
  	params = { 
  		grant_type: "fb_exchange_token",
  		client_id: ENV["FB_APP_ID1"],
  		client_secret: ENV["FB_APP_SECRET1"],
  		fb_exchange_token: short_token
  	}
  	headers =	{ 'Content-Type' => 'application/json' }
    response = self.class.get("/oauth/access_token", query: params, headers: headers)
    if response.code == 200
    	return parse_token(response.body)
    else
    	return ""
    end
  end

  def get_user_id(token)
  	options = { query:{
  		fields: "id",
  		access_token: token
  		}
  	}
  	response = self.class.get("/me", options)
  	return response
  end

  def self.get_id(fb_api,long_token,short_token)
    response = fb_api.get_user_id(long_token)
    if response.code == 200
      @token = long_token
      return JSON.parse(response.body)["id"]
    end
    #Lets try it with the short token now
    response = fb_api.get_user_id(short_token)
    if response.code == 200
      @token = short_token
      return JSON.parse(response.body)["id"]
    end
    return nil
  end

  private 

  	def parse_token(response)
  		#access_token={access-token}&expires={seconds-til-expiration}
  		index = response.index('&')
  		start_index = "access_token=".size
  		length = index - start_index
  		return response.slice(start_index,length)
  	end

end