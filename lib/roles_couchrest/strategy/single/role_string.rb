require 'roles_couchrest/strategy/single'

module RoleStrategy::SimplyStored
  module RoleString    
    def self.default_role_attribute
      :role_string
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end 

      def in_role(role_name) 
        where(role_attribute => role_name)
      end
    end

    
    module Implementation
      include Roles::SimplyStored::Strategy::Single
              
      def new_role role
        role = role.kind_of?(Array) ? role.first : role
        role.to_s
      end

      def new_roles *roles
        new_role roles.flatten.first
      end
      
      def present_role role
        return role if role.kind_of? Array
        role.split(',').map(&:to_sym)
      end

      def set_empty_role
        self.send("#{role_attribute}=", "")
      end

      alias_method :present_roles, :present_role            
    end

    extend Roles::Generic::User::Configuration
    configure :num => :single
  end
end


