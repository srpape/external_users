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
 
      # We'll never give out permissions, only take them away.
      # If the real function returns false, just return here.
      # Also, we make no changes for non-external users, so just return if the user isn't one.
      if !result || !external?
	return result
      end

      # We're only changing project level permissions
      # If we're not dealing with a project context, just return the result
      if !context || !context.is_a?(Project)
        return result
      end

      # The user is external, and we're dealing with a project
      # Now just return true if the user is a member of the project, false otherwise
       
      # Get the target project's roles
      roles = roles_for_project(context)
      return false unless roles 

      # Return true if the user is a member of the project 
      return roles.any? {|role| role.member? }
    end
  end
end

# Add module to Issue
User.send(:include, UserPatch)
