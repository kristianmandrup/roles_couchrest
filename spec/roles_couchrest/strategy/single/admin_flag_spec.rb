require 'spec_helper'
use_roles_strategy :admin_flag

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :admin_flag, :default
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :admin_flag
end

load 'roles_couchrest/strategy/api_examples.rb'


