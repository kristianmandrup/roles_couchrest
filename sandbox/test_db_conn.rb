require 'rubygems'
require 'couchrest' 
require 'couchrest_extended_document'

SERVER = CouchRest.new
DB = SERVER.database!('contact-manager')

class Contact < CouchRest::ExtendedDocument
  use_database DB
  
  property :first_name
  property :last_name, :alias => :family_name
  property :company_name
  property :job_title
  property :address, :cast_as => 'Address'
  property :phone_numbner
  property :email
  timestamps!
  
  view_by :first_name
  
end

class Address < Hash
  include ::CouchRest::CastedModel
  
  property :line_1
  property :line_2
  property :city
  property :state
  property :zip_code
  property :country, :default => "USA"

  def to_s
    address_str = "#{line_1}"
    address_str << ",\n #{line_2}" if line_2
    address_str << "\n"
    address_str << "#{city}, " if city
    address_str << "#{state}" if state
    address_str << " #{zip_code}" if zip_code
    address_str << "\n#{country}" if country
    address_str
  end
end

puts "You have #{Contact.all.size} contacts"
# => You have 0 contacts

puts "Let's add a new contact!"
matt = Contact.new(:first_name => 'Matt', :last_name => 'Aimonetti')
# just showing you can edit the instance after creating it
matt.company_name = 'm|a agile'
# assigning a new address to our contact
matt.address = Address.new(:line_1 => 'Main Street', :city => 'San Diego', :state => 'CA')
# We could have also assign each value separately like that:
matt.address.zip_code = 92128
puts "new contact to add: #{matt.inspect}"
# => new contact to add: {"updated_at"=>nil, "company_name"=>"m|a agile", "first_name"=>"Matt", "couchrest-type"=>"Contact", "address"=>{"city"=>"San Diego", "zip_code"=>92128, "line_1"=>"Main Street", "state"=>"CA"}, "last_name"=>"Aimonetti", "created_at"=>nil}
matt.save
puts "You now have #{Contact.all.size} contact(s)"
# => You now have 1 contact(s)

# let's reload the objects from the database
matt_from_db = Contact.first
puts matt_from_db.inspect
# => {"updated_at"=>Sun May 17 21:52:01 -0700 2009, "company_name"=>"m|a agile", "_id"=>"749a89203d5cb217d18295d416f9fb2b", "_rev"=>"1-2705668756", "first_name"=>"Matt", "couchrest-type"=>"Contact", "address"=>{"city"=>"San Diego", "zip_code"=>92128, "line_1"=>"Main Street", "state"=>"CA"}, "last_name"=>"Aimonetti", "created_at"=>Sun May 17 21:52:01 -0700 2009}

# let's just output the address to see if it works as expected
puts matt_from_db.address
# => Main Street
# => San Diego, CA 92128

# let's delete the DB since it was just a test
DB.delete!

