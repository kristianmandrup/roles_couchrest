require 'rspec/core'
require 'rails' 
# require "couch_object"
require 'simply_stored/couch'
require 'roles_couchrest'

# CouchPotato::Config.database_name = "http://localhost:5984/roles_couchrest"
# server = Couch::Server.new("localhost", "5984")
# server.delete("/roles_couchrest")

require 'couchrest' 

server = CouchRest::Server.new #'localhost:5984'
# puts "Available: #{server.available_databases}"
# puts "DBs: #{server.databases}"
db_name = 'roles_couchrest'

# delete db if it exists
if server.databases.include? db_name
  # puts "delete database: #{db_name}"
  server.database(db_name).delete!
end

# puts "DBs: #{server.databases}"
if !server.databases.include? db_name
  # puts "create db: #{db_name}"
  server.create_db(db_name) 
end

CouchPotato::Config.database_name = "http://localhost:5984/#{db_name}"

RSpec.configure do |config|
  config.mock_with :mocha
end


