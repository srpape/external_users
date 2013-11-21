require_dependency 'user'

module UserPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :allowed_to?, :external_check
    end
  end

  module InstanceMethods
    def external?
      external_field = self.custom_value_for UserCustomField.where( :name=>"External User" ).first
      return external_field && external_field.value == "1"
    end

    def allowed_to_with_external_check?(action, context, options={}, &block)
      # Call the original
      result = allowed_to_without_external_check?(action, context, options, &block)
	
      if !result
	return result
      end

      # If the context is a project, and the normal method returns true,
      # then check if the user is external
      if context && context.is_a?(Project)
        # If it's a public project, make sure the user isn't an external user
	if(context.is_public? && !external?)
          return false;
        end

        # Get the target project's roles
        roles = roles_for_project(context)
        return false unless roles 

        # Return true if the user is a member of the project 
        return roles.any? {|role| role.member? }
      end
    end
  end
end

# Add module to Issue
User.send(:include, UserPatch)
