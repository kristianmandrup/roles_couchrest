require 'spec_helper'
use_roles_strategy :roles_mask

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :roles_mask, :default
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :roles_mask
end

load 'roles_couchrest/strategy/api_examples.rb'


