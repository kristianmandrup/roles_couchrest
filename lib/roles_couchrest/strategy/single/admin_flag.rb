require 'roles_couchrest/strategy/single'

module RoleStrategy::SimplyStored
  module AdminFlag    
    def self.default_role_attribute
      :admin_flag
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end
           
      def in_role(role_name) 
        case role_name.downcase.to_sym
        when :admin              
          send("find_by_#{role_attribute}", true)
        else
          send("find_by_#{role_attribute}", false)
        end          
      end
    end

    module Implementation
      include Roles::SimplyStored::Strategy::Single
      
      # def role_attribute
      #   strategy_class.roles_attribute_name
      # end

      def set_empty_role
        self.send("#{role_attribute}=", false)
      end
          
      # assign roles
      def roles=(*new_roles) 
        first_role = new_roles.flatten.first

        if first_role.nil?
          self.send("#{role_attribute}=", false)
          return  
        end        

        if valid_role?(first_role)
          self.send("#{role_attribute}=", first_role.admin?) 
        else
          raise ArgumentError, "The role #{first_role} is not a valid role"
        end
      end

      # query assigned roles
      def roles
        role = self.send(role_attribute) ? strategy_class.admin_role_key : strategy_class.default_role_key
        [role]
      end
      alias_method :roles_list, :roles

      
      # query assigned roles
      def exchange_roles *_roles
        options = last_option _roles
        raise ArgumentError, "Must take an options hash as last argument with a :with option signifying which role(s) to replace with" if !options || !options.kind_of?(Hash)        
        remove_roles(_roles.to_symbols)
        options[:with] = options[:with].flatten if options[:with].kind_of? Array
        
        add_roles options[:with]
      end
      alias_method :exchange_role, :exchange_roles

    end # Implementation
    
    extend Roles::Generic::User::Configuration
    configure :num => :single
  end   
end
