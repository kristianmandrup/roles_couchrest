module Roles::Base
  def valid_roles_are(*role_list)
    strategy_class.valid_roles = role_list.to_symbols
  end
end

module Roles::SimplyStored  
  def self.included(base) 
    base.extend Roles::Base
    base.extend ClassMethods
    base.orm_name = :simply_stored
  end

  module ClassMethods      
    
    MAP = {
      :admin_flag   => "property :admin_flag, :type => :boolean",
      # :many_roles   => "references_many :many_roles, :stored_as => :array, :class_name => 'Role', :default => []",
      # :one_role     => "references_one :one_role, :class_name => 'Role'",

      # :embed_many_roles   => "many :many_roles, :class_name => 'Role'",
      # :embed_one_role     => "one :one_role, :class_name => 'Role'",

      :roles_mask   => "property :roles_mask, :type => Integer, :default => 0",
      :role_string  => "property :role_string,   :type => String",
      :role_strings => "property :role_strings,  :type => Array",
      :roles_string => "property :roles_string,  :type => String"
    }
    
    def strategy name, options = {}
      if (options == :default || options[:config] == :default) && MAP[name]
        instance_eval MAP[name] 
      end

      if !options.kind_of? Symbol
        role_class = options[:role_class] ? options[:role_class].to_s.camelize.constantize : (Role if defined? Role)
      end
      puts "set_role_strategy: #{name}, #{options}"
      set_role_strategy name, options
    end    
  end
end
