module Authorization
	module V1
		module User

			#Used in the controller
			
			def self.index?(tokenUser)
				return true
			end

			def self.show?(targetUser,tokenUser)
				return true
			end

			def self.update?(targetUser,tokenUser)
				if targetUser != tokenUser
					#Can only update your own data
					return false
				else
					return true
				end
			end

			def self.destroy?(targetUser,tokenUser)
				if targetUser != tokenUser
					#Can only destroy your own data
					return false
				else
					return true
				end
			end

			def self.register?
				return true
			end

			def self.login?
				return true
			end

			def self.logout?(tokenUser)
				return true
			end

			#Used in the serializer, current_user may be nil

			def self.include_id?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
				return true
			end

	    def self.include_email?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	return true
	    end

	    def self.include_username?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	return true
	    end

	    def self.include_fb_user_id?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
				return true
			end

	    def self.include_password_digest?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	return false
	    end

	    def self.include_created_at?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	return true
	    end

	    def self.include_updated_at?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	return true
	    end

	    
	    def self.include_tokens?(current_user,user_object,options)
	    	action = options[:url_options][:_recall][:action]
	    	controller = options[:url_options][:_recall][:controller]
	    	#if action == "index" && controller == "api/v1/users"
	    		#return false
	    	#end
	    	return false
	    end
	    
			private
			
		end
	end
end