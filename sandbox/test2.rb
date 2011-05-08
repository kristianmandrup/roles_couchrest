require 'rspec/core'
require 'rails' 
require 'simply_stored/couch'
require 'roles_simply_stored'
require 'couchrest' 

server = CouchRest::Server.new #'localhost:5984'
puts "Available: #{server.available_databases}"
puts "DBs: #{server.databases}"
db_name = 'docs'

# delete db if it exists
if server.databases.include? db_name
  puts "delete database: #{db_name}"
  server.database(db_name).delete!
end

puts "DBs: #{server.databases}"
if !server.databases.include? db_name
  puts "create db: #{db_name}"
  server.create_db(db_name) 
end

CouchPotato::Config.database_name = "http://localhost:5984/#{db_name}"

class Document
  include SimplyStored::Couch
  
  property :title
  # enable_soft_delete # will use :deleted_at attribute by default
end

doc = Document.create(:title => 'secret')
doc2 = Document.create(:title => 'project')
doc3 = Document.create(:title => 'info')

# titles = Document.find_all_by_title(['secret','project','info'])
titles = ['secret','project','info']

doc_titles = Document.all.select do |d|
  titles.include?(d.title)
end

puts "By title #{doc_titles}"
# => []


doc.delete
doc2.delete
doc3.delete


# => [doc]


# class User
#   include SimplyStored::Couch
#   
#   property :login
#   property :age
#   property :accepted_terms_of_service, :type => :boolean
#   property :last_login, :type => Time
# end
# 
# user = User.new(:login => 'Bert', :age => 12, :accepted_terms_of_service => true, :last_login = Time.now)
# user.save
# 
# User.find_by_age(12).login
# # => 'Bert'
# 
# User.all
# # => [user]
# 
# class Post
#   include SimplyStored::Couch
#   
#   property :title
#   property :body
#   
#   belongs_to :user
# end
# 
# class User
#   has_many :posts
# end
# 
# post = Post.create(:title => 'My first post', :body => 'SimplyStored is so nice!', :user => user)
# 
# user.posts
# # => [post]
# 
# Post.find_all_by_title_and_user_id('My first post', user.id).first.body
# # => 'SimplyStored is so nice!'
# 
# post.destroy
# 
# user.posts(:force_reload => true)
# # => []