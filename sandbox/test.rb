require 'rspec/core'
require 'rails' 
require 'simply_stored/couch'
require 'roles_simply_stored'

CouchPotato::Config.database_name = "http://localhost:5984/roles_simply_stored"

class User 
  include SimplyStored::Couch

  property :name, :type => String
  
  belongs_to :role
end

class Role
  include SimplyStored::Couch

  has_many :users, :dependent => :destroy

  property :name, :type => String
end

User.all.each{|u| u.delete }
Role.all.each{|r| r.delete }


role1 = Role.create(:name => 'guest')
role2 = Role.create(:name => 'admin')

user = User.create(:name => 'The user', :role => role1)

puts "Roles created: #{Role.all}"  

puts "User: #{User.first}"

found = Role.find_all_by_names('guest admin')

puts "Found #{found}"