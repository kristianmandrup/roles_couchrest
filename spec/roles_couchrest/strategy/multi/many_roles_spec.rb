require 'spec_helper'
use_roles_strategy :many_roles

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :many_roles, :default
  role_class :role  
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :many_roles
end

load 'roles_couchrest/strategy/api_examples.rb'


