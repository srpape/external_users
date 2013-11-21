require_dependency 'project'

module ProjectPatch
  def self.included(base) # :nodoc:
    base.extend ClassMethods
    base.class_eval do
      class << self
        alias_method_chain :allowed_to_condition, :external_check
      end 
    end
  end

  module ClassMethods
    def allowed_to_condition_with_external_check(user, permission, options={})
      # Call the original
      result = allowed_to_condition_without_external_check(user, permission, options)

      if !user.external?
        return result
      end
	
      result.sub! "#{Project.table_name}.is_public = #{connection.quoted_true} OR ", ""

    end
  end
end

# Add module to Issue
Project.send(:include, ProjectPatch)
