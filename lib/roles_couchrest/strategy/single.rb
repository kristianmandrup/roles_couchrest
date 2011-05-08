require 'roles_couchrest/strategy/shared'

module Roles::SimplyStored
  module Strategy
    module Single
      include Shared
      
      # assigns first valid role from list of roles
      def add_roles *role_names
        new_roles = select_valid_roles(role_names)
        self.role = new_roles.first if !new_roles.empty?
      end

      # should remove the current single role (set = nil) 
      # only if it is contained in the list of roles to be removed
      def remove_roles *roles
        roles = roles.flat_uniq
        if roles_diff(roles).empty? || roles.include?(self.role)
          set_empty_role
        end
        true
      end            
    end
  end
end