module Census
  class ApplicationController < ::ApplicationController

    protected
    
    def restrict_access
      render :text => 'Not authorized', :status => :unauthorized unless instance_eval Census::configuration.admin_role
    end
  end
end
