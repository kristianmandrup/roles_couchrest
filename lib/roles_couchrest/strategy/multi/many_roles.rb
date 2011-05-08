require 'roles_couchrest/strategy/multi'

class UserRole
  include SimplyStored::Couch  
  belongs_to :user
  belongs_to :role
end

module RoleStrategy::SimplyStored
  module ManyRoles
    def self.default_role_attribute
      :many_roles
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.has_many :user_roles, :foreign_key => 'role'
      base.has_many :users, :through => :user_roles
      
      # base.has_many :many_roles, :through => :user_roles, :foreign_key => :role
      # base.has_many :user_roles      
    end

    module ClassMethods  
      def role_attribute
        strategy_class.roles_attribute_name
      end       

      def role_id_attribute
        "#{role_attribute}_ids".to_sym
      end       
        
      def in_role(role_name)
        role = Role.find_role(role_name)
        res = all(role_id_attribute => role.id)        
      end

      def in_any_role(*role_names)                          
        role_ids = Role.find_roles(role_names).map{|role| role.id}
        all(role_id_attribute.in => role_ids)
      end
    end
    
    module Implementation 
      include Roles::SimplyStored::Strategy::Multi

      def has_roles?(*roles_names)
        compare_roles = extract_roles(roles_names.flat_uniq)
        (roles_list & compare_roles).not.empty?      
      end

      def get_roles
        self.send(role_attribute)
      end      

      def roles
        get_roles.to_a.map do |role|
          role.respond_to?(:sym) ? role.to_sym : role
        end
      end

      def roles_list
        my_roles = [roles].flat_uniq
        return [] if my_roles.empty?
        has_role_class? ? my_roles.map{|r| r.name.to_sym } : my_roles          
      end
        
      # assign multiple roles
      def roles=(*role_names)
        role_names = role_names.flat_uniq
        role_names = extract_roles(role_names)
        return nil if role_names.empty?
        valids = role_class.find_roles(role_names).to_a
        vrs = select_valid_roles role_names
        set_roles(vrs)
      end

      def new_roles *role_names
        role_class.find_roles(extract_roles role_names)
      end

      def present_roles roles_names
        roles_names.to_a.map{|role| role.name.to_s.to_sym}
      end

      def set_empty_roles
        self.send("#{role_attribute}=", [])
      end
    end 
    
    extend Roles::Generic::User::Configuration
    configure :type => :role_class     
  end
end

