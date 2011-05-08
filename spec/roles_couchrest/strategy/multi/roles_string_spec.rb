require 'spec_helper'
use_roles_strategy :role_strings

class User 
  include SimplyStored::Couch
  include Roles::SimplyStored
  
  strategy :role_strings, :default
  valid_roles_are :admin, :guest  

  property :name, :type => String
end

def api_name
  :role_strings
end

load 'roles_couchrest/strategy/api_examples.rb'


