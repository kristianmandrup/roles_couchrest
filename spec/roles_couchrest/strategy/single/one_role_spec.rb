require 'spec_helper'
use_roles_strategy :one_role

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :one_role, :default
  role_class :role
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :one_role
end

load 'roles_couchrest/strategy/api_examples.rb'


