class ApplicationController < ActionController::Base



	def after_sign_in_path_for(resource)
  		case resource
  			when Admin
    			admin_top_path
    		when Customer
    			public_items_path
		end
	end
	def after_sign_out_path_for(resource)
      if resource == :admin
      new_admin_session_path
      else
      new_customer_session_path
      end
    end



end
