require 'spec_helper'
use_roles_strategy :role_string

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :role_string, :default
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :role_string
end

load 'roles_couchrest/strategy/api_examples.rb'


